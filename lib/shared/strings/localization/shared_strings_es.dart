import 'shared_strings.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class SharedStringsEs extends SharedStrings {
  SharedStringsEs([String locale = 'es']) : super(locale);

  @override
  String get genericErrorRetry => 'Intentar nuevamente';

  @override
  String get genericErrorTitle => 'Tuvimos un problema';

  @override
  String get genericErrorSubTitle => 'Encontramos un problema al cargar los datos. Por favor, intente nuevamente';

  @override
  String get meditometer => 'Meditómetro';

  @override
  String get realTime => 'EN TIEMPO REAL';

  @override
  String get millions => 'Millones ';

  @override
  String get minutesMeditatedWorld => 'de minutos meditados en el mundo';

  @override
  String get countriesReached => 'Países alcanzados';

  @override
  String get hello => 'Hola';
}
