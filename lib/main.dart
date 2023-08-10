import 'package:cinco_minutos_meditacao/core/di/setup.dart';
import 'package:cinco_minutos_meditacao/core/firebase/firebase_options.dart';
import 'package:cinco_minutos_meditacao/core/flavors/flavors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Inicializa o Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Configura o Firebase Crashlytics. apenas em ambiente de produção.
  if (F.isProd) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  // Configura a biblioteca para utilizar o idioma atual do dispositivo.
  Intl.defaultLocale = 'pt_BR';
  Intl.systemLocale = await findSystemLocale();

  /// inicializa a injeção de dependências. principais
  DI.setup();

  /// Executa a aplicação.
  runApp(DI.app);
}
