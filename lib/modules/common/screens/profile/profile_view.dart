import 'package:auto_route/annotations.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/components/form_profile.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  @override
  void initState() {
    stateController.showNormalState();

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
        onRetry: () {},
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
                // nameUser: model.userResponse!.name.split(" ").first,
                // description1: CommonStrings.of(context).homeHeaderDescription1,
                // photo: model.userResponse!.profilePhotoPath,
                // updateImage: () => presenter.updateImageProfile(),
                nameUser: "Gabriela",
                colorName: AppColors.chineseBlue,
                description1: "Clique aqui e complete o seu perfil!",
                updateImage: () {},
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
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          Text(
            "Atualize seus dados de perfil e acompanhe seus minutos meditados!",
            style: TextStyle(
              fontSize: 19,
              color: AppColors.frankBlue,
              fontWeight: FontWeight.w400,
              fontFamily: 'Heebo',
            ),
          ),
          FormProfile(
            onRegister: () {},
          ),
        ],
      ),
    );
  }
}
