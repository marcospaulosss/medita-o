import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_contracts.dart';

/// Presenter responsável pela lógica de negócios da tela de boas-vindas.
///
/// Este presenter implementa o padrão MVP (Model-View-Presenter) e é responsável
/// por gerenciar toda a lógica de negócios da tela de boas-vindas do aplicativo.
/// Ele atua como uma camada intermediária entre a view e o repositório de dados.
///
/// Principais responsabilidades:
/// * Navegação inteligente entre telas (login/home) baseada no estado de autenticação
/// * Registro de eventos analíticos para monitoramento de uso
/// * Verificação da primeira visita do usuário ao aplicativo
/// * Gerenciamento do estado de autenticação do usuário
///
/// Este presenter se comunica com:
/// * [WelcomeViewContract] para interação com a view
/// * [Repository] para acesso a dados
/// * [AppRouter] para navegação entre telas
class WelcomePresenter extends Presenter {
  /// Router responsável pela navegação do aplicativo.
  ///
  /// Utiliza o [AppRouter] para gerenciar a navegação entre diferentes telas
  /// do aplicativo de forma type-safe e com suporte a deep linking.
  final AppRouter _router;

  /// Repositório que gerencia os dados da tela de boas-vindas.
  ///
  /// Responsável por:
  /// * Verificar o estado de autenticação
  /// * Registrar eventos analíticos
  /// * Gerenciar dados persistentes
  final Repository _repository;

  /// Contrato com a view para comunicação bidirecional.
  ///
  /// Esta propriedade permite que o presenter atualize a interface do usuário
  /// através dos métodos definidos em [WelcomeViewContract].
  @override
  WelcomeViewContract? view;

  /// Cria uma nova instância do presenter da tela de boas-vindas.
  ///
  /// Requer as seguintes dependências:
  /// * [_router]: Instância do [AppRouter] para gerenciamento de navegação
  /// * [_repository]: Instância do [Repository] para acesso a dados
  ///
  /// Exemplo de uso:
  /// ```dart
  /// final presenter = WelcomePresenter(appRouter, welcomeRepository);
  /// ```
  WelcomePresenter(this._router, this._repository);

  /// Método chamado quando a tela é aberta.
  ///
  /// Responsável por:
  /// * Registrar o evento de abertura da tela para análise de uso
  /// * Realizar inicializações necessárias
  ///
  /// Este método é assíncrono e deve ser chamado assim que a tela
  /// for montada e estiver pronta para interação do usuário.
  @override
  Future<void> onOpenScreen() async {
    _repository.sendOpenScreenEvent();
  }

  /// Gerencia a navegação do usuário com base no estado de autenticação.
  ///
  /// Este método:
  /// 1. Verifica o estado de autenticação do usuário através do repositório
  /// 2. Redireciona o usuário para a tela apropriada:
  ///    * Se autenticado: navega para [HomeRoute]
  ///    * Se não autenticado: navega para [LoginRoute]
  ///
  /// A navegação é feita usando [goToReplace] para substituir a tela atual
  /// na pilha de navegação, evitando que o usuário retorne para a tela
  /// de boas-vindas ao pressionar o botão voltar.
  @override
  Future<void> navigateToLogin() async {
    final isLogged = await _repository.isLogged();
    
    if (isLogged) {
      _router.goToReplace(const HomeRoute());
    } else {
      _router.goToReplace(const LoginRoute());
    }
  }
}
