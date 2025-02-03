import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_model.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/shared/strings/localization/calendar_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CalendarMeditation extends StatefulWidget {
  /// Calendário da semana
  final List<int> weekCalendar;

  /// Calendário do mês
  final List<int> monthCalendar;

  /// Calendário do ano
  final List<int> yearCalendar;

  /// Tipo de calendário
  final CalendarType type;

  /// função para obter o calendário da semana
  final Function getCalendar;

  /// - [weekCalendar] : Calendário da semana
  /// - [monthCalendar] : Calendário do mês
  /// - [yearCalendar] : Calendário do ano
  /// - [type] : Tipo de calendário
  /// - [getWeekCalendar] : função para obter o calendário da semana
  /// Construtor
  const CalendarMeditation({
    required this.weekCalendar,
    required this.monthCalendar,
    required this.yearCalendar,
    required this.type,
    required this.getCalendar,
    super.key,
  });

  @override
  State<CalendarMeditation> createState() => _CalendarMeditationState();
}

class _CalendarMeditationState extends State<CalendarMeditation> {
  /// Tipo de visualização atual
  String _currentView = 'Semana';

  /// Data focada
  DateTime _focusedDate = DateTime.now();

  @override
  void initState() {
    if (widget.type == CalendarType.week) {
      _currentView = 'Semana';
    } else if (widget.type == CalendarType.month) {
      _currentView = 'Mês';
    } else {
      _currentView = 'Ano';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCalendarToggle(),
        _buildCalendar(),
      ],
    );
  }

  Widget _buildCalendarToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildToggleButton('Semana', CalendarStrings.of(context).weekToUpper),
        const SizedBox(width: 4),
        _buildToggleButton('Mês', CalendarStrings.of(context).monthToUpper),
        const SizedBox(width: 4),
        _buildToggleButton('Ano', CalendarStrings.of(context).yearToUpper),
      ],
    );
  }

  Widget _buildToggleButton(String text, String titleCalendarName) {
    bool isSelected = _currentView == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentView = text;
        });

        if (_currentView == 'Semana') {
          widget.getCalendar(_focusedDate, CalendarType.week);
        } else if (_currentView == 'Mês') {
          widget.getCalendar(_focusedDate, CalendarType.month);
        } else {
          widget.getCalendar(_focusedDate, CalendarType.year);
        }
      },
      child: Container(
        width: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.blueNCS,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: isSelected ? AppColors.white : AppColors.blueMana,
            width: 1,
          ),
        ),
        child: Text(
          titleCalendarName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isSelected ? AppColors.blueNCS : AppColors.blueMana,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40, bottom: 16, top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildCalendarHeader(),
          const SizedBox(height: 16),
          _buildCalendarBody(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    String title;
    if (_currentView == 'Semana') {
      title = CalendarStrings.of(context).calendarTitle;
    } else if (_currentView == 'Mês') {
      title = DateFormat('MMMM | yy', 'pt_BR').format(_focusedDate);
    } else {
      title = _focusedDate.year.toString();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.steelWoolColor,
          ),
          onPressed: _previousPeriod,
        ),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.blueMana,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.chevron_right,
            color: AppColors.steelWoolColor,
          ),
          onPressed: _nextPeriod,
        ),
      ],
    );
  }

  Widget _buildCalendarBody() {
    switch (_currentView) {
      case 'Semana':
        return _buildWeekCalendar();
      case 'Mês':
        return _buildMonthCalendar();
      case 'Ano':
        return _buildYearCalendar();
      default:
        return Container();
    }
  }

  Widget _buildWeekCalendar() {
    DateTime startOfWeek =
        _focusedDate.subtract(Duration(days: _focusedDate.weekday % 7));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (index) {
                  DateTime currentDate = startOfWeek.add(Duration(days: index));
                  String dayLetter = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'][index];
                  String dayNumber = currentDate.day.toString().padLeft(2, '0');

                  return Column(
                    children: [
                      Text(
                        dayLetter,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dayNumber,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.weekCalendar
                  .map((minutes) => _buildDayBalloon(minutes))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayBalloon(int minutes) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          minutes > 0
              ? AppImages.calendarBalloonBlue
              : AppImages.calendarBalloon,
        ),
        Center(
          child: Text(
            minutes.toString(),
            style: TextStyle(
              color: minutes > 0 ? AppColors.white : AppColors.blueMana,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthCalendar() {
    int daysInMonth =
        DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    int firstDayOfWeek =
        DateTime(_focusedDate.year, _focusedDate.month, 1).weekday % 7;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S']
              .map(
                (day) => Text(
                  day,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.steelWoolColor,
                    fontSize: 18,
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 4),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.85,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemCount: 42,
          itemBuilder: (context, index) {
            int day = index - firstDayOfWeek + 1;

            if (day > 0 && day <= daysInMonth) {
              int minutes = widget.monthCalendar[day - 1];

              return LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day.toString().padLeft(2, '0'),
                        // Formatação do dia para sempre ter dois dígitos
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.steelWoolColor,
                        ),
                      ),
                      const SizedBox(height: 1),
                      SizedBox(
                        width: constraints.maxWidth * 0.85,
                        height: constraints.maxHeight * 0.60,
                        child: _buildDayBalloon(minutes),
                      ),
                    ],
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  Widget _buildYearCalendar() {
    final List<String> monthNames = [
      'JAN',
      'FEV',
      'MAR',
      'ABR',
      'MAI',
      'JUN',
      'JUL',
      'AGO',
      'SET',
      'OUT',
      'NOV',
      'DEZ'
    ];

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      children: List.generate(12, (index) {
        return _buildMonthBalloon(
            monthNames[index], widget.yearCalendar[index]);
      }),
    );
  }

  Widget _buildMonthBalloon(String month, int minutes) {
    return Column(
      children: [
        Text(
          month,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
        SizedBox(
          width: 50,
          height: 45,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                minutes > 0
                    ? AppImages.calendarBalloonBlue
                    : AppImages.calendarBalloon,
                fit: BoxFit.contain,
              ),
              if (minutes > 0)
                Text(
                  minutes.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _previousPeriod() {
    if (_currentView == 'Semana') {
      _focusedDate = _focusedDate.subtract(const Duration(days: 7));
      widget.getCalendar(_focusedDate, CalendarType.week);
    } else if (_currentView == 'Mês') {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1, 1);
      widget.getCalendar(_focusedDate, CalendarType.month);
    } else {
      _focusedDate = DateTime(_focusedDate.year - 1);
      widget.getCalendar(_focusedDate, CalendarType.year);
    }

    setState(() {});
  }

  void _nextPeriod() {
    setState(() {
      if (_currentView == 'Semana') {
        _focusedDate = _focusedDate.add(const Duration(days: 7));
        widget.getCalendar(_focusedDate, CalendarType.week);
      } else if (_currentView == 'Mês') {
        _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1, 1);
        widget.getCalendar(_focusedDate, CalendarType.month);
      } else {
        _focusedDate = DateTime(_focusedDate.year + 1);
        widget.getCalendar(_focusedDate, CalendarType.year);
      }
    });
  }
}
