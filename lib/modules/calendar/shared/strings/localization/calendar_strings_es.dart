import 'calendar_strings.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class CalendarStringsEs extends CalendarStrings {
  CalendarStringsEs([String locale = 'es']) : super(locale);

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
