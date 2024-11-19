import 'calendar_strings.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CalendarStringsEn extends CalendarStrings {
  CalendarStringsEn([String locale = 'en']) : super(locale);

  @override
  String get youMeditated => 'Você meditou:';

  @override
  String get minutes => 'Minutos esta ';

  @override
  String get week => 'semana';

  @override
  String get month => 'mês';

  @override
  String get year => 'ano';
}
