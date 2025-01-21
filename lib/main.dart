import 'package:cinco_minutos_meditacao/core/di/setup.dart';
import 'package:cinco_minutos_meditacao/core/firebase/firebase_options.dart';
import 'package:cinco_minutos_meditacao/core/flavors/flavors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

late final FirebaseApp app;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Inicializa o Firebase.
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instanceFor(app: app);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  // Configura a biblioteca para utilizar o idioma atual do dispositivo.
  Intl.defaultLocale = 'pt_BR';
  Intl.systemLocale = await findSystemLocale();

  // Ativa o wakelock na inicialização do app
  WakelockPlus.enable();

  /// inicializa a injeção de dependências. principais
  DI.setup();

  /// Executa a aplicação.
  runApp(DI.app);
}
