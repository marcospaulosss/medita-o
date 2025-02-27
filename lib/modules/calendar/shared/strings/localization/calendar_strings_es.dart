import 'calendar_strings.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class CalendarStringsEs extends CalendarStrings {
  CalendarStringsEs([String locale = 'es']) : super(locale);

  @override
  String get youMeditated => 'Usde meditó:';

  @override
  String get minutes => 'Min de esta';

  @override
  String get minutes2 => 'Min de este';

  @override
  String get week => 'semana';

  @override
  String get month => 'mese';

  @override
  String get year => 'año';

  @override
  String get calendarTitle => 'Tiempo por semana';

  @override
  String get weekToUpper => 'Semana';

  @override
  String get monthToUpper => 'Mese';

  @override
  String get yearToUpper => 'Anno';
}
