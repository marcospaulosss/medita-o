import 'package:auto_route/annotations.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/components/divider_buttons.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/components/form_login.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/components/login_buttons.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/components/questions_login.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_presenter.dart';
import 'package:cinco_minutos_meditacao/shared/components/background_default.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/container.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/controller.dart';
import 'package:flutter/material.dart';

/// Tela responsável pelo login do usuário
/// utilizando o Google
@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  /// Presenter da tela de login
  Presenter presenter = resolve<LoginPresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  @override
  void initState() {
    stateController.showNormalState();

    presenter.onOpenScreen();

    super.initState();
  }

  @override
  void dispose() {
    stateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiStateContainer(
      controller: stateController,
      normalStateBuilder: (context) => buildScaffold(),
      loadingStateBuilder: (context) => const Loading(),
      errorStateBuilder: (context) => GenericErrorContainer(
        onRetry: () => requestLoginGoogle,
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
                  "assets/images/balão-5min 1.png",
                  height: 241,
                  width: 166,
                ),
                const FormLogin(),
                const QuestionsLogin(),
                const DividerButtons(),
                LoginButtons(requestLoginGoogle: requestLoginGoogle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Solicita o login utilizando o Google
  void requestLoginGoogle() async {
    stateController.showLoadingState();
    var (_, error) = await presenter.loginGoogle();
    if (error != null) {
      stateController.showErrorState();
      return;
    }
    stateController.showNormalState();

    presenter.goToHome();
  }
}
