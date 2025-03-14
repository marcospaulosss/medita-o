import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';

/// Contrato que define a interface da view da tela de boas-vindas.
///
/// Este contrato faz parte do padrão MVP (Model-View-Presenter) e define
/// os métodos que a view deve implementar para manter a comunicação
/// bidirecional com o presenter.
///
/// A view é responsável por:
/// * Renderizar a interface do usuário
/// * Capturar interações do usuário
/// * Atualizar a UI baseada nas respostas do presenter
///
/// Implementações desta interface devem garantir que:
/// * A UI seja atualizada de forma consistente
/// * As interações do usuário sejam propagadas corretamente para o presenter
abstract class WelcomeViewContract {}

/// Contrato que define as responsabilidades do presenter da tela de boas-vindas.
///
/// Este contrato é parte fundamental do padrão MVP e define a interface
/// que o presenter deve implementar para gerenciar a lógica de negócios
/// da tela de boas-vindas.
///
/// O presenter atua como intermediário entre a view e o repository, sendo responsável por:
/// * Gerenciar o ciclo de vida da view
/// * Controlar a navegação entre telas
/// * Coordenar operações de verificação de primeira visita
/// * Gerenciar o estado de autenticação do usuário
/// * Processar eventos da view e atualizar o estado conforme necessário
///
/// Este contrato estende [ViewBinding] para estabelecer a ligação com a view
/// através do [WelcomeViewContract].
abstract class Presenter extends ViewBinding<WelcomeViewContract> {
  /// Método chamado durante a inicialização da tela de boas-vindas.
  ///
  /// Este método é responsável por realizar as seguintes operações:
  /// * Registrar eventos de analytics para monitoramento de uso
  /// * Verificar se é a primeira visita do usuário ao aplicativo
  /// * Verificar o estado de autenticação do usuário
  ///
  /// Deve ser chamado assim que a tela for montada e estiver pronta
  /// para interação do usuário.
  ///
  /// Retorna:
  /// * [Future<void>] que completa quando todas as operações de inicialização
  ///   forem concluídas
  Future<void> onOpenScreen();

  /// Gerencia a navegação do usuário para a próxima tela apropriada.
  ///
  /// Este método é responsável por:
  /// * Verificar o estado de autenticação do usuário
  /// * Direcionar para a tela de login caso não esteja autenticado
  /// * Direcionar para a tela inicial caso já esteja autenticado
  ///
  /// A navegação deve ser implementada de forma a:
  /// * Evitar retorno indesejado para a tela de boas-vindas
  /// * Manter um fluxo de navegação consistente
  /// * Preservar o estado da aplicação
  ///
  /// Retorna:
  /// * [Future<void>] que completa quando a navegação for concluída
  Future<void> navigateToLogin();
}

/// Contrato que define as responsabilidades do repository da tela de boas-vindas.
///
/// Este contrato é parte do padrão Repository e define a interface para
/// acesso e manipulação dos dados relacionados à tela de boas-vindas.
///
/// O repository é responsável por:
/// * Gerenciar o acesso a dados persistentes
/// * Registrar eventos analíticos
/// * Verificar e persistir o estado de primeira visita
/// * Gerenciar o estado de autenticação do usuário
///
/// Este contrato garante que:
/// * Os dados sejam acessados de forma consistente
/// * As operações de persistência sejam realizadas corretamente
/// * Os eventos analíticos sejam registrados adequadamente
abstract class Repository {
  /// Registra o evento analítico de abertura da tela de boas-vindas.
  ///
  /// Este método deve ser chamado quando a tela de boas-vindas for
  /// exibida para o usuário. É responsável por:
  /// * Enviar dados para a plataforma de analytics
  /// * Registrar informações sobre o uso do aplicativo
  /// * Contribuir para métricas de engajamento
  void sendOpenScreenEvent();

  /// Verifica o estado de autenticação do usuário no aplicativo.
  ///
  /// Este método é responsável por:
  /// * Consultar o armazenamento seguro
  /// * Verificar a validade das credenciais
  /// * Determinar se o usuário possui uma sessão ativa
  ///
  /// Retorna:
  /// * [Future<bool>] que resolve para:
  ///   * `true` se o usuário estiver autenticado e com sessão válida
  ///   * `false` caso contrário
  Future<bool> isLogged();
}
