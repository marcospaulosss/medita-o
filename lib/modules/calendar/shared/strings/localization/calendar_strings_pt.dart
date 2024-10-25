import 'calendar_strings.dart';

/// The translations for Portuguese (`pt`).
class CalendarStringsPt extends CalendarStrings {
  CalendarStringsPt([String locale = 'pt']) : super(locale);

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
