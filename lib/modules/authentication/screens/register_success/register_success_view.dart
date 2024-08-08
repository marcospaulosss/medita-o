import 'package:auto_route/annotations.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/components/container_success_widget.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/components/background_default.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:flutter/material.dart';

/// Tela responsável pelo registro do usuário
@RoutePage()
class RegisterSuccessView extends StatefulWidget {
  const RegisterSuccessView({super.key});

  @override
  State<RegisterSuccessView> createState() => RegisterSuccessViewState();
}

@visibleForTesting
class RegisterSuccessViewState extends State<RegisterSuccessView> {
  /// Presenter da tela de login
  Presenter presenter = resolve<RegisterSuccessPresenter>();

  @override
  void initState() {
    presenter.onOpenScreen();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 30),
                const ContainerSuccess(),
                const SizedBox(height: 20),
                buildDescriptionAction(),
                const SizedBox(height: 20),
                IconLabelButton(
                  onTap: () => presenter.goToHome(),
                  width: double.infinity,
                  height: 55,
                  label: Text(
                    AuthenticationStrings.of(context).startMeditating,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: AppColors.brilliance2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichText buildDescriptionAction() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: AuthenticationStrings.of(context).completeYourRegistration,
        style: const TextStyle(
          fontSize: 20,
          color: AppColors.germanderSpeedwell,
          fontWeight: FontWeight.w700,
        ),
        children: [
          TextSpan(
            text: AuthenticationStrings.of(context).haveAccessContent,
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.dimGray,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
