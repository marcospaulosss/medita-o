import 'shared_strings.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SharedStringsEn extends SharedStrings {
  SharedStringsEn([String locale = 'en']) : super(locale);

  @override
  String get genericErrorRetry => 'Try again';

  @override
  String get genericErrorTitle => 'There was a problem.';

  @override
  String get genericErrorSubTitle => 'We found a problem loading the data, please try again.';

  @override
  String get meditometer => 'Meditometer';

  @override
  String get realTime => 'REAL TIME';

  @override
  String get millions => 'Millions';

  @override
  String get minutesMeditatedWorld => 'Of meditated minutes in the world';

  @override
  String get countriesReached => 'COUNTRIES REACHED';

  @override
  String get hello => 'Hello';
}
