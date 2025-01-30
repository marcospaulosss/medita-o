import 'shared_strings.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class SharedStringsIt extends SharedStrings {
  SharedStringsIt([String locale = 'it']) : super(locale);

  @override
  String get genericErrorRetry => 'riprova ';

  @override
  String get genericErrorTitle => 'Abbiamo avuto un problema';

  @override
  String get genericErrorSubTitle => 'Si è verificato un problema durante il caricamento dei dati. Riprova più tardi.';

  @override
  String get meditometer => 'Meditometro';

  @override
  String get realTime => 'IN TEMPO REALE';

  @override
  String get millions => 'milioni ';

  @override
  String get minutesMeditatedWorld => 'di Minuti meditati nel mondo';

  @override
  String get countriesReached => 'Paes1 raggiunt1';

  @override
  String get hello => 'Ciao';
}
