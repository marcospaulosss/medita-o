import 'package:auto_route/annotations.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/components/form_profile.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_contract.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_model.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => ProfileViewState();
}

@visibleForTesting
class ProfileViewState extends State<ProfileView>
    implements ProfileViewContract {
  /// Presenter
  Presenter presenter = resolve<ProfilePresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  /// modelo da tela
  ProfileModel model = ProfileModel();

  @override
  void initState() {
    presenter.bindView(this);
    presenter.initPresenter();

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
      normalStateBuilder: (context) => buildScaffold(context),
      loadingStateBuilder: (context) => const Loading(),
      errorStateBuilder: (context) => GenericErrorContainer(
        message: messageError,
        onRetry: () => presenter.initPresenter(),
      ),
    );
  }

  Widget buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBlue.withOpacity(0.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: AppHeader(
                nameUser: model.userResponse!.name.split(" ").first,
                description1: CommonStrings.of(context).homeHeaderDescription1,
                photo: model.userResponse!.profilePhotoPath,
                updateImage: () => presenter.updateImageProfile(),
              ),
            ),
            buildBody(),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, bottom: 40, right: 40),
      child: Column(
        children: [
          Text(
            CommonStrings.of(context).profileUpdateInfo,
            style: const TextStyle(
              fontSize: 19,
              color: AppColors.frankBlue,
              fontWeight: FontWeight.w400,
              fontFamily: 'Heebo',
            ),
          ),
          FormProfile(
            onRegister: () {},
            profileModel: model,
          ),
          _buildPrivacyPolicy(),
          const Divider(
            color: AppColors.frankBlue,
            thickness: 1,
            height: 30,
          ),
          _buildExitApp(),
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicy() {
    return GestureDetector(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: CommonStrings.of(context).privacyPolicy1,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: AppColors.frankBlue,
            fontFamily: 'Heebo',
          ),
          children: [
            TextSpan(
              text: CommonStrings.of(context).privacyPolicy2,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.frankBlue,
                decoration: TextDecoration.underline,
                fontFamily: 'Heebo',
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        debugPrint("Política de Privacidade");
      },
    );
  }

  Widget _buildExitApp() {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            CommonStrings.of(context).exitApp,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.frankBlue,
              fontFamily: 'Heebo',
            ),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.exit_to_app,
            color: AppColors.frankBlue,
            size: 20,
          ),
        ],
      ),
      onTap: () => presenter.logOut(),
    );
  }

  @override
  void showError(String message) {
    setState(() {
      messageError = message;
    });
    stateController.showErrorState();
  }

  @override
  void showLoading() {
    stateController.showLoadingState();
  }

  @override
  void showNormalState(ProfileModel model) {
    setState(() {
      this.model = model;
    });

    stateController.showNormalState();
  }
}
