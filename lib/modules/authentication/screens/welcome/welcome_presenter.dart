import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_repository.dart';

/// Presenter responsável pela lógica de negócios da tela de boas-vindas.
///
/// Este presenter lida com:
/// * Navegação para a tela de login
/// * Registro de eventos analíticos
/// * Verificação da primeira visita do usuário
/// * Verificação do estado de login do usuário
class WelcomePresenter extends Presenter {
  /// Router para navegação
  final StackRouter _router;

  /// Repositório para acesso a dados
  final Repository _repository;

  /// Construtor que recebe as dependências necessárias
  ///
  /// Parameters:
  ///   router: Instância de [StackRouter] para navegação
  ///   repository: Instância de [WelcomeRepository] para acesso a dados
  WelcomePresenter(this._router, this._repository);

  @override
  WelcomeViewContract? view;

  @override
  Future<void> onOpenScreen() async {
    _repository.sendOpenScreenEvent();
  }

  @override
  Future<void> navigateToLogin() async {
    _router.push(const LoginRoute());
  }
}
