import 'shared_strings.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class SharedStringsFr extends SharedStrings {
  SharedStringsFr([String locale = 'fr']) : super(locale);

  @override
  String get genericErrorRetry => 'Essayer à nouveau';

  @override
  String get genericErrorTitle => 'Nous avons eu un problème.';

  @override
  String get genericErrorSubTitle => 'Nous avons rencontré un problème lors du chargement des données. Veuillez réessayer';

  @override
  String get meditometer => 'Méditomètre';

  @override
  String get realTime => 'EN TEMPS RÉEL';

  @override
  String get millions => 'millions ';

  @override
  String get minutesMeditatedWorld => 'des minutes méditées dans le monde';

  @override
  String get countriesReached => 'paus atteint';

  @override
  String get hello => 'Salut';
}
