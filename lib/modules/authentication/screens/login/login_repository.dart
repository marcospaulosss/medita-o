import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/authenticate_google_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/social_client_api.dart';

class LoginRepository extends Repository {
  /// Gerenciador de analytics
  final AnalyticsManager _analyticsManager;

  /// Cliente de autenticação social
  final SocialClientApi _socialClientApi;

  /// - [analyticsManager] : Gerenciador de analytics
  /// - [_socialClientApi] : Cliente de autenticação social
  LoginRepository(
    this._analyticsManager,
    this._socialClientApi,
  );

  /// Envia o evento de analytics associado a tela de login
  @override
  void sendOpenScreenEvent() {
    _analyticsManager.sendEvent(AuthenticationEvents.loginScreenOpened);
  }

  /// Autentica o usuário utilizando o Google
  @override
  Future<void> authenticateUserByGoogle(String idToken) async {
    AuthenticateGoogleRequest request =
        AuthenticateGoogleRequest(idToken: idToken);
    var response = await _socialClientApi.authGoogle(request);
  }
}
