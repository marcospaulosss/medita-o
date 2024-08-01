import 'shared_strings.dart';

/// The translations for Spanish Castilian (`es`).
class SharedStringsEs extends SharedStrings {
  SharedStringsEs([String locale = 'es']) : super(locale);

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
}
