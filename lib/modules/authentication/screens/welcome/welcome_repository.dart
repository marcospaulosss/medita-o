import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_contracts.dart';

/// Repositório responsável por gerenciar dados relacionados à tela de boas-vindas.
///
/// Este repositório é responsável por gerenciar todas as operações de dados
/// relacionadas à tela de boas-vindas do aplicativo. Ele implementa a interface
/// [Repository] e fornece funcionalidades para:
///
/// * Registro de eventos analíticos quando o usuário interage com a tela
/// * Verificação do estado de autenticação do usuário
/// * Gerenciamento de dados persistentes relacionados à tela de boas-vindas
///
/// O repositório utiliza:
/// * [AnalyticsManager] para rastreamento de eventos
/// * [SecureStorage] para armazenamento seguro de dados
class WelcomeRepository implements Repository {
  /// Gerenciador responsável pelo registro de eventos analíticos.
  ///
  /// Utilizado para rastrear interações do usuário e comportamento do app
  /// através do envio de eventos predefinidos.
  final AnalyticsManager _analyticsManager;

  /// Gerenciador de armazenamento seguro para dados sensíveis.
  ///
  /// Responsável por armazenar e recuperar dados de forma segura,
  /// especialmente informações relacionadas ao estado de autenticação do usuário.
  final SecureStorage _secureStorage;

  /// Cria uma nova instância do repositório de boas-vindas.
  ///
  /// Requer as seguintes dependências:
  /// * [_analyticsManager]: Instância do gerenciador de analytics para registro de eventos
  /// * [_secureStorage]: Instância do armazenamento seguro para manipulação de dados persistentes
  ///
  /// Exemplo de uso:
  /// ```dart
  /// final repository = WelcomeRepository(analyticsManager, secureStorage);
  /// ```
  WelcomeRepository(this._analyticsManager, this._secureStorage);

  /// Registra o evento de abertura da tela de boas-vindas.
  ///
  /// Este método deve ser chamado sempre que a tela de boas-vindas for exibida
  /// para o usuário. Ele utiliza o [_analyticsManager] para enviar um evento
  /// predefinido [AuthenticationEvents.welcomeScreenOpened].
  @override
  void sendOpenScreenEvent() {
    _analyticsManager.sendEvent(AuthenticationEvents.welcomeScreenOpened);
  }

  /// Verifica se o usuário está autenticado no aplicativo.
  ///
  /// Retorna:
  /// * `true` se o usuário estiver autenticado
  /// * `false` caso contrário
  ///
  /// Este método é assíncrono e utiliza o [_secureStorage] para verificar
  /// o estado de autenticação do usuário.
  @override
  Future<bool> isLogged() async {
    return await _secureStorage.isLogged;
  }
}
