import 'calendar_strings.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class CalendarStringsFr extends CalendarStrings {
  CalendarStringsFr([String locale = 'fr']) : super(locale);

  @override
  String get youMeditated => 'Vous avez médité:';

  @override
  String get minutes => 'minutes';

  @override
  String get week => 'semaine';

  @override
  String get month => 'mois';

  @override
  String get year => 'année';

  @override
  String get calendarTitle => '???';

  @override
  String get weekToUpper => 'Semaine';

  @override
  String get monthToUpper => 'Mois';

  @override
  String get yearToUpper => 'Année';
}
