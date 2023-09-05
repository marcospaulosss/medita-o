import 'package:cinco_minutos_meditacao/shared/services/log_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  /// Credenciais para o firebase
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late final FirebaseApp app;
  late final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _authenticated = false;

  bool get isAuthenticated => _authenticated;

  Future<(User?, dynamic)> loginGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      /// Credenciais para o firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print("Google Nome: ${googleUser.displayName}");
      print("Google Email: ${googleUser.email}");
      print("Google Foto: ${googleUser.photoUrl}");
      print("Google id: ${googleUser.id}");

      UserCredential result = await _auth.signInWithCredential(credential);
      final User fireUser = result.user!;
      print("firebase Nome: ${fireUser.displayName}");
      print("firebase Email: ${fireUser.email}");
      print("firebase Foto: ${fireUser.photoURL}");
      print("firebase metadata: ${fireUser.metadata}");
      print("firebase phone: ${fireUser.phoneNumber}");
      print("firebase id: ${fireUser.uid}");

      _authenticated = true;

      return (fireUser, null);
    } catch (e, s) {
      FirebaseCrashlytics.instance.log("Erro ao realizar login com o Google");
      LogService().log("Erro login com o Google", e, s);

      return (null, Future.error(e));
    }
  }

  Future<Object?> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      _authenticated = false;
    } catch (e) {
      return e;
    }

    return null;
  }
}
