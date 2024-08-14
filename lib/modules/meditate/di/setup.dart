import 'package:cinco_minutos_meditacao/modules/meditate/di/five_minutes.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/di/meditate_info.dart';

void setupInjectors() {
  MeditateInfoInjector.setup();
  FiveMinutesInjector.setup();
}
