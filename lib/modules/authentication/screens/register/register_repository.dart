import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_contracts.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

class RegisterRepository extends Repository {
  /// Gerenciador de analytics
  final AnalyticsManager _analyticsManager;

  /// Cliente de autenticação social
  final ClientApi _clientApi;

  /// Erro customizado
  final CustomError _error;

  /// Armazenamento seguro
  final SecureStorage _secureStorage;

  /// - [_analyticsManager] : Gerenciador de analytics
  /// - [_socialClientApi] : Cliente de autenticação social
  /// - [_error] : Erro customizado
  /// - [_secureStorage] : Armazenamento seguro
  RegisterRepository(
    this._analyticsManager,
    this._clientApi,
    this._error,
    this._secureStorage,
  );

  /// Envia o evento de analytics associado a tela de cadastro do usuário
  @override
  void sendOpenScreenEvent() {
    _analyticsManager.sendEvent(AuthenticationEvents.registerScreenOpened);
  }
}
