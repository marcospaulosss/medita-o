import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/log_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  /// Credenciais para o firebase
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late final FirebaseApp app;
  late final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<(AuthCredential?, Object?)> loginGoogle() async {
    try {
      debugPrint("Iniciando login com o Google...");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint("Login cancelado pelo usuário.");
        return (null, "Login cancelado");
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      debugPrint("Autenticando...");
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return (credential, null);
    } catch (error, stackTrace) {
      debugPrint("Erro durante o login com o Google: $error");
      LogService().log("Erro login com o Google", error, stackTrace);
      var err = CustomError().sendErrorToCrashlytics(
          code: ErrorCodes.loginGoogleError, stackTrace: stackTrace);
      return (null, err);
    }
  }

  Future<(AccessToken?, CustomError?)> loginFacebook() async {
    try {
      final LoginResult resultFacebook = await FacebookAuth.instance.login();
      switch (resultFacebook.status) {
        case LoginStatus.success:
          final AccessToken accessToken = resultFacebook.accessToken!;
          return (accessToken, null);
          break;
        case LoginStatus.cancelled:
          debugPrint('Login cancelado pelo usuário.');
          break;
        case LoginStatus.failed:
          debugPrint('Erro no login: ${resultFacebook.message}');
          var err = CustomError().sendErrorToCrashlytics(
              code: ErrorCodes.loginFacebookError,
              stackTrace: StackTrace.current);
          return (null, err);
          break;
        case LoginStatus.operationInProgress:
          final AccessToken accessToken = resultFacebook.accessToken!;
          return (accessToken, null);
          break;
      }

      return (null, null);
    } catch (error, stackTrace) {
      debugPrint("Erro durante o login com o Facebook: $error");
      LogService().log("Erro login com o Facebook", error, stackTrace);
      var err = CustomError().sendErrorToCrashlytics(
          code: ErrorCodes.loginFacebookError, stackTrace: stackTrace);
      return (null, err);
    }
  }

  Future<Object?> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      await FacebookAuth.instance.logOut();
    } catch (e) {
      return e;
    }

    return null;
  }
}
