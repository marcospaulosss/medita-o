import 'shared_strings.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class SharedStringsDe extends SharedStrings {
  SharedStringsDe([String locale = 'de']) : super(locale);

  @override
  String get genericErrorRetry => 'Erneut versuchen';

  @override
  String get genericErrorTitle => 'Wir haben einen Fehler erhalten';

  @override
  String get genericErrorSubTitle => 'Es ist ein Problem beim Laden der Daten aufgetreten. Bitte versuchen Sie es erneut.';

  @override
  String get meditometer => 'Meditometer';

  @override
  String get realTime => 'IN ECHTZEIT';

  @override
  String get millions => 'Millionen';

  @override
  String get minutesMeditatedWorld => 'Minuten, die in der Welt meditiert werden';

  @override
  String get countriesReached => 'Länder die wir erreicht haben';

  @override
  String get hello => 'Hallo!';
}
