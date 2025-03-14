import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_contracts.dart';

/// Repositório responsável por gerenciar dados relacionados à tela de boas-vindas.
///
/// Este repositório lida com:
/// * Registro de eventos analíticos
/// * Verificação e marcação da primeira visita do usuário
/// * Verificação do estado de login do usuário
class WelcomeRepository implements Repository {
  /// Gerenciador de analytics para registro de eventos
  final AnalyticsManager _analyticsManager;

  /// Gerenciador de armazenamento seguro para leitura e escrita de dados
  final SecureStorage _secureStorage;

  /// Construtor que recebe as dependências necessárias
  ///
  /// Parameters:
  ///   analytics: Instância de [AnalyticsManager] para registro de eventos
  ///   secureStorage: Instância de [SecureStorage] para leitura e escrita de dados
  WelcomeRepository(this._analyticsManager, this._secureStorage);

  @override
  void sendOpenScreenEvent() {
    _analyticsManager.sendEvent(AuthenticationEvents.welcomeScreenOpened);
  }

  @override
  Future<bool> isLogged() async {
    return await _secureStorage.isLogged;
  }
}
