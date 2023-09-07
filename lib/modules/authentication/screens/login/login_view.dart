import 'package:auto_route/annotations.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/components/background_default.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/container.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: IconLabelButton(
          onTap: requestLoginGoogle,
          width: 350,
          height: 55,
          image: SvgPicture.asset(
            'assets/images/icons/google_logo.svg',
            height: 30,
          ),
          label: Text(
            AuthenticationStrings.of(context).yourGoogleAccount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff2B448C),
              fontFamily: 'Apertura',
            ),
          ),
        ),
      ),
    );
  }

  /// Solicita o login utilizando o Google
  void requestLoginGoogle() async {
    stateController.showLoadingState();
    var (userGoogle, error) = await presenter.loginGoogle();
    if (error != null) {
      stateController.showErrorState();
      return;
    }
    stateController.showNormalState();

    presenter.goToHome();
  }
}
