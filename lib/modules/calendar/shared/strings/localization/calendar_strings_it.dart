import 'calendar_strings.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class CalendarStringsIt extends CalendarStrings {
  CalendarStringsIt([String locale = 'it']) : super(locale);

  @override
  String get youMeditated => 'Hai meditato:';

  @override
  String get minutes => 'minuti ';

  @override
  String get week => 'settimana';

  @override
  String get month => 'mese';

  @override
  String get year => 'anno';

  @override
  String get calendarTitle => 'Tempo settimanale';

  @override
  String get weekToUpper => 'Settimana';

  @override
  String get monthToUpper => 'Mese';

  @override
  String get yearToUpper => 'Anno';
}
