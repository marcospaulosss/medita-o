import 'shared_strings.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SharedStringsEn extends SharedStrings {
  SharedStringsEn([String locale = 'en']) : super(locale);

  @override
  String get genericErrorRetry => 'Try again';

  @override
  String get genericErrorTitle => 'We had a problem.';

  @override
  String get genericErrorSubTitle => 'We encountered a problem loading data. Please try again.';

  @override
  String get meditometer => 'Meditometer';

  @override
  String get realTime => 'IN REAL TIME';

  @override
  String get millions => 'millions';

  @override
  String get minutesMeditatedWorld => 'from MinutesMeditatedWorld';

  @override
  String get countriesReached => 'COUNTRIES REACHED';

  @override
  String get hello => 'Hello';
}
