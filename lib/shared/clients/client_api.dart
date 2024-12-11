import 'dart:io';

import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/shared/clients/interceptor.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/authenticate_google_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/create_new_meditations_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/user_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/authenticate_google_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/countries_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/get_banners_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/month_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/register_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/share_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/states_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/week_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/year_calendar_response.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'client_api.g.dart';

@RestApi()
abstract class ClientApi {
  factory ClientApi(
      EnvironmentManager environmentManager, TokenInterceptor interceptor) {
    var dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    dio.interceptors.add(interceptor);

    return _ClientApi(
      dio,
      baseUrl: environmentManager.apiBaseUrl,
    );
  }

  /// - [Social] : Cliente de autenticação social
  /// Solicita a autenticação do usuário utilizando o Google
  @POST('/auth/google')
  Future<AuthenticateGoogleResponse> authGoogle(
      @Body() AuthenticateGoogleRequest token);

  /// - [Auth] : Cliente de autenticação
  /// Solicita a autenticação do usuário utilizando email e senha no servidor
  @POST('/login')
  Future<RegisterResponse> login(@Body() AuthRequest body);

  /// - [Register] : Cliente de criação de conta
  /// Solicita a criação de uma conta no servidor
  @POST('/register')
  Future<RegisterResponse> register(@Body() AuthRequest body);

  /// - [User] : Obtem informações do usuário
  /// Obtem informações do usuário logado
  @GET('/user')
  Future<UserResponse> user();

  /// Obtem informações do usuário logado
  @PATCH('/user')
  Future<void> updateUser(@Body() UserRequest body);

  /// solicita a atualização da foto do usuário
  @POST('/user/photo')
  @MultiPart()
  Future<dynamic> uploadPhoto(@Part(name: "photo") File photo);

  /// - [ Meditations ] : Cliente de meditações
  /// Obtem as meditações disponíveis
  @GET('/meditations')
  Future<MeditationsResponse> meditations();

  /// Obtem as meditações realizadas pelo usuário
  @GET('/meditations/{user_id}')
  Future<MeditationsResponse> meditationsByUser(@Path('user_id') String userId);

  /// solicita a criação de uma nova meditação
  @POST('/meditations')
  Future<void> createNewMeditation(@Body() CreateNewMeditationsRequest body);

  /// - [ Calendar ] : Cliente de calendário
  /// Obtem as meditações realizadas pelo usuário
  @GET('/calendar/week')
  Future<WeekCalendarResponse> calendarWeek(@Query('date') String date);

  /// Obtem as meditações realizadas pelo usuário no mes
  @GET('/calendar/month')
  Future<MonthCalendarResponse> calendarMonth(
      @Query('month') int month, @Query('year') int year);

  /// Obtem as meditações realizadas pelo usuário no ano
  @GET('/calendar/year')
  Future<YearCalendarResponse> calendarYear(@Query('year') int year);

  /// - [ Helpers ] : Cliente de ajuda e complementos
  /// Obtem o paizes disponíveis
  @GET('/countries')
  Future<CountriesResponse> countries();

  /// Obtem os estados de um país
  @GET('/states')
  Future<StatesResponse> states(@Query('country_id') int countryId);

  /// - [ Share ] : Cliente de compartilhamento
  /// Obtem o paizes disponíveis
  @GET('/share')
  Future<ShareResponse> getImagesShare();

  /// - [ banners ] : Cliente de banners
  /// Obtem os banners disponíveis
  @GET('/banners')
  Future<GetBannersResponse> getBanners();
}
