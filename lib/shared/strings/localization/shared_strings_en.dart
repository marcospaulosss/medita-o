import 'shared_strings.dart';

/// The translations for English (`en`).
class SharedStringsEn extends SharedStrings {
  SharedStringsEn([String locale = 'en']) : super(locale);

  @override
  String get genericErrorRetry => 'Tentar novamente';

  @override
  String get genericErrorTitle => 'Tivemos um problema.';

  @override
  String get genericErrorSubTitle => 'Encontramos um problema ao carregar os dados. Por favor, tente novamente.';

  @override
  String get meditometer => 'Meditômetro';

  @override
  String get realTime => 'EM TEMPO REAL';

  @override
  String get millions => 'milhões ';

  @override
  String get minutesMeditatedWorld => 'de Minutos meditados no mundo';

  @override
  String get countriesReached => 'PAÍSES ALCANÇADOS';

  @override
  String get hello => 'Olá';
}
