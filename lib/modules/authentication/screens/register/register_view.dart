import 'package:auto_route/annotations.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/components/form_register.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/components/background_default.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/container.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/controller.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';

/// Tela responsável pelo registro do usuário
@RoutePage()
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => RegisterViewState();
}

@visibleForTesting
class RegisterViewState extends State<RegisterView>
    implements RegisterViewContract {
  /// Presenter da tela de login
  Presenter presenter = resolve<RegisterPresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  /// Variável para armazenar o estado de erro de email inválido
  late bool errorEmailInvalid = false;

  /// Variável para armazenar a requisição de autenticação
  late AuthRequest authRequest =
      AuthRequest(name: "", email: "", password: "", passwordConfirmation: "");

  @override
  void initState() {
    presenter.bindView(this);
    presenter.onOpenScreen();

    showNormalState();

    super.initState();
  }

  @override
  void dispose() {
    stateController.dispose();
    presenter.unbindView();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiStateContainer(
      controller: stateController,
      normalStateBuilder: (context) => buildScaffold(),
      loadingStateBuilder: (context) => const Loading(),
      errorStateBuilder: (context) => GenericErrorContainer(
        onRetry: () => onRegister(
            authRequest.name, authRequest.email, authRequest.password),
        message: messageError,
      ),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      body: BackgroundDefault(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(
              children: [
                Image.asset(
                  AppImages.balloon,
                  height: 241,
                  width: 166,
                ),
                FormRegister(
                  onRegister: onRegister,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onRegister(name, email, password) async {
    authRequest = AuthRequest(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: password);
    await presenter.register(authRequest);
  }

  /// Exibe a mensagem de erro
  @override
  void showError(String message) {
    messageError = message;
    stateController.showErrorState();
  }

  /// Exibe a tela de carregamento
  @override
  void showLoading() {
    stateController.showLoadingState();
  }

  /// Exibe a tela normal
  @override
  void showNormalState() {
    stateController.showNormalState();
  }

  /// Exibe a mensagem de erro de email inválido
  @override
  void showErrorEmailInvalid() {
    setState(() {
      errorEmailInvalid = true;
    });
  }

  /// Mostra a snackbar de credenciais inválidas
  @override
  void showInvalidCredentialsSnackBar({String? message}) {
    String msg = message ?? AuthenticationStrings.of(context).invalidParameters;
    var snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
