import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';

/// Contrato que define os métodos que a view deve implementar.
///
/// Este contrato é responsável por:
abstract class WelcomeViewContract {}

/// Contrato que define as responsabilidades do presenter
///
/// Este contrato é responsável por:
/// * Gerenciar o ciclo de vida da view
/// * Controlar a navegação
/// * Coordenar as operações de verificação de primeira visita e login
abstract class Presenter extends ViewBinding<WelcomeViewContract> {
  /// Chamado quando a tela é aberta
  ///
  /// Realiza:
  /// * Registro de evento de analytics
  /// * Verificação de primeira visita
  /// * Verificação de login
  Future<void> onOpenScreen();

  /// Navega para a tela de login
  Future<void> navigateToLogin();
}

/// Contrato que define as responsabilidades do repository
///
/// Este contrato é responsável por:
/// * Registro de eventos analíticos
/// * Verificação e marcação da primeira visita
/// * Verificação do estado de login
abstract class Repository {
  /// Envia o evento de analytics associado ao carregamento da tela de boas-vindas
  void sendOpenScreenEvent();

  /// Verifica se o usuário está logado no aplicativo
  ///
  /// Returns:
  ///   true se o usuário estiver logado, false caso contrário
  Future<bool> isLogged();
}
