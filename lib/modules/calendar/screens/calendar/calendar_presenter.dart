import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_contract.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_model.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_model.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/month_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/week_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/year_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:intl/intl.dart';

class CalendarPresenter implements Presenter {
  /// View
  @override
  CalendarViewContract? view;

  /// Repositório
  final Repository _repository;

  /// Router
  final AppRouter _router;

  /// variável de ambiente
  final EnvironmentManager environmentManager;

  /// - [repository] : Repositório
  /// - [router] : Router
  /// - [environmentManager] : variável de ambiente
  /// construtor
  CalendarPresenter(this._repository, this._router, this.environmentManager);

  /// Model para contrução da tela
  CalendarModel model = CalendarModel();

  /// evento disparado ao abrir a tela
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }

  /// Inicializa o presenter
  @override
  Future<void> initPresenter() async {
    onOpenScreen();

    view!.showLoading();
    var (user, errorUser) = await _repository.requestUser();
    if (errorUser != null) {
      view!.showError(errorUser.getErrorMessage);
      return;
    }

    var (meditations, errorMeditations) =
        await _repository.requestMeditations();
    if (errorMeditations != null) {
      view!.showError(errorMeditations.getErrorMessage);
      return;
    }

    if (user != null && meditations != null) {
      model.userResponse = user;
      model.meditationsResponse = meditations;
    }

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    var (weekCalendar, errorCalendar) =
        await _repository.requestCalendarWeek(formattedDate);
    if (errorCalendar != null) {
      view!.showError(errorCalendar.getErrorMessage);
      return;
    }

    List<int> meditationsWeek = [];
    for (var item in weekCalendar!.week!.values) {
      meditationsWeek.add(item['minutes']);
    }

    model.weekCalendar = meditationsWeek;
    model.weekCalendarResponse = weekCalendar;
    model.calendarType = CalendarType.week;

    view!.showNormalState(model);
  }

  /// Atualiza a imagem de perfil do usuário
  @override
  Future<void> updateImageProfile() async {
    _router.goTo(CameraRoute(), onClose: (result) async {
      if (result == null) {
        return;
      }

      if (result is CustomError) {
        CustomError err = CustomError();
        err.code = ErrorCodes.cameraError;
        view!.showError(err.getErrorMessage);
        return;
      }

      CustomError? err = await _repository.uploadImageProfile(result);
      if (err != null) {
        view!.showError(err.getErrorMessage);
        return;
      }

      var (user, errorUser) = await _repository.requestUser();
      if (errorUser != null) {
        view!.showError(errorUser.getErrorMessage);
        return;
      }
      model.userResponse = user;
      view!.showNormalState(model);
    });
  }

  @override
  Future<CalendarModel> getCalendar(String date, CalendarType type) async {
    WeekCalendarResponse? weekCalendar;
    MonthCalendarResponse? monthCalendar;
    YearCalendarResponse? yearCalendar;
    CustomError? errorCalendar;

    switch (type) {
      case CalendarType.year:
        (yearCalendar, errorCalendar) =
            await _repository.requestCalendarYear(date);
        if (errorCalendar != null) {
          view!.showError(errorCalendar.getErrorMessage);
          return model;
        }

        int numberOfDaysInYear = 12;
        List<int> meditationsYear = List.filled(numberOfDaysInYear, 0);
        if (yearCalendar!.year != null && yearCalendar.year!.isNotEmpty) {
          yearCalendar!.year!.forEach((year, data) {
            // Converter o dia para um índice (subtrair 1 porque a lista começa em 0)
            int yearIndex = int.parse(year) - 1;
            // Atualizar a lista com os minutos do dia específico
            meditationsYear[yearIndex] = data['minutes'];
          });
        }
        model.yearCalendar = meditationsYear;

      case CalendarType.month:
        (monthCalendar, errorCalendar) =
            await _repository.requestCalendarMonth(date);
        if (errorCalendar != null) {
          view!.showError(errorCalendar.getErrorMessage);
          return model;
        }

        int numberOfDaysInMonth = 31;
        List<int> meditationsMonth = List.filled(numberOfDaysInMonth, 0);
        if (monthCalendar!.month != null && monthCalendar.month!.isNotEmpty) {
          monthCalendar!.month!.forEach((day, data) {
            // Converter o dia para um índice (subtrair 1 porque a lista começa em 0)
            int dayIndex = int.parse(day) - 1;
            // Atualizar a lista com os minutos do dia específico
            meditationsMonth[dayIndex] = data['minutes'];
          });
        }
        model.monthCalendar = meditationsMonth;

      default:
        (weekCalendar, errorCalendar) =
            await _repository.requestCalendarWeek(date);
        if (errorCalendar != null) {
          view!.showError(errorCalendar.getErrorMessage);
          return model;
        }

        List<int> meditationsWeek = [];
        for (var item in weekCalendar!.week!.values) {
          meditationsWeek.add(item['minutes']);
        }
        model.weekCalendar = meditationsWeek;
    }

    model.weekCalendarResponse = weekCalendar;
    model.monthCalendarResponse = monthCalendar;
    model.yearCalendarResponse = yearCalendar;

    return model;
  }

  @override
  Future<void> goToSocialShare(String calendarType) async {
    switch (calendarType) {
      case "week":
        _router.goTo(ShareRoute(params: ShareModel(type: ShareType.week)));
        break;
      case "month":
        _router.goTo(ShareRoute(params: ShareModel(type: ShareType.month)));
        break;
      case "year":
        _router.goTo(ShareRoute(params: ShareModel(type: ShareType.year)));
        break;
      default:
        _router.goTo(ShareRoute(params: ShareModel(type: ShareType.week)));
    }
  }
}
