import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> setupFirebaseAuthMocks() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase
  await Firebase.initializeApp();
}
