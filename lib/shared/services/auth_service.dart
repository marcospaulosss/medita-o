import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/log_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  /// Credenciais para o firebase
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late final FirebaseApp app;
  late final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<(AuthCredential?, Object?)> loginGoogle() async {
    try {
      print("Iniciando login com o Google...");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Login cancelado pelo usuário.");
        return (null, "Login cancelado");
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Autenticando...");
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return (credential, null);
    } catch (error, stackTrace) {
      print("Erro durante o login com o Google: $error");
      LogService().log("Erro login com o Google", error, stackTrace);
      var err = CustomError().sendErrorToCrashlytics(
          code: ErrorCodes.loginGoogleError, stackTrace: stackTrace);
      return (null, err);
    }
  }

  Future<void> loginFacebook() async {
    try {
      final LoginResult resultFacebook = await FacebookAuth.instance.login();
      switch (resultFacebook.status) {
        case LoginStatus.success:
          // Login bem-sucedido
          final AccessToken accessToken = resultFacebook.accessToken!;
          // print('Access Token: ${accessToken.token}');
          break;
        case LoginStatus.cancelled:
          print('Login cancelado pelo usuário.');
          break;
        case LoginStatus.failed:
          print('Erro no login: ${resultFacebook.message}');
          break;
        case LoginStatus.operationInProgress:
        // TODO: Handle this case.
      }

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
    } catch (e, s) {
      FirebaseCrashlytics.instance.log("Erro ao realizar login com o Google");
      LogService().log("Erro login com o Google", e, s);
    }
  }

  Future<Object?> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      return e;
    }

    return null;
  }
}
