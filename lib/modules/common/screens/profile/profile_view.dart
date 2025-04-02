import 'package:auto_route/annotations.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/components/form_profile.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_contract.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_model.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/user_request.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Tela de perfil do usuário que permite visualizar e editar informações pessoais.
/// 
/// Esta tela exibe:
/// - Foto de perfil do usuário
/// - Informações básicas (nome, sobrenome, email)
/// - Data de nascimento
/// - Gênero
/// - Localização (país e estado)
/// - Link para política de privacidade
/// - Opção para sair do aplicativo
@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => ProfileViewState();
}

/// Estado da tela de perfil que implementa a interface [ProfileViewContract].
/// 
/// Gerencia o estado da tela, incluindo:
/// - Controle de estados (normal, loading, erro)
/// - Interação com o presenter
/// - Atualização da UI
@visibleForTesting
class ProfileViewState extends State<ProfileView>
    implements ProfileViewContract {
  /// Presenter responsável pela lógica de negócios
  Presenter presenter = resolve<ProfilePresenter>();

  /// Controlador do estado da tela que gerencia os diferentes estados (normal, loading, erro)
  final stateController = MultiStateContainerController();

  /// Mensagem de erro a ser exibida quando ocorrer uma falha
  late String messageError = "";

  /// Modelo que contém os dados do perfil do usuário
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

  /// Constrói o scaffold principal da tela com o cabeçalho e o corpo
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
                colorName: AppColors.frankBlue,
              ),
            ),
            buildBody(),
          ],
        ),
      ),
    );
  }

  /// Constrói o corpo principal da tela com o formulário e opções adicionais
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
            onRegister: (UserRequest user) {
              presenter.updateUser(user);
            },
            profileModel: model,
            onSelectedCountry: (countryId) => getCities(countryId),
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

  /// Constrói o widget da política de privacidade com link clicável
  /// 
  /// Ao ser clicado, tenta abrir a URL da política de privacidade.
  /// Se não conseguir abrir, exibe uma mensagem de erro via SnackBar.
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
      onTap: () async {
        final Uri url = Uri.parse(CommonStrings.of(context).privacyPolicy);
        if (!await launchUrl(url)) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Não foi possível abrir a política de privacidade'),
              ),
            );
          }
        }
      },
    );
  }

  /// Constrói o widget de saída do aplicativo
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

  /// Busca as cidades/estados para um determinado país
  /// 
  /// [countryId] ID do país selecionado
  /// Retorna uma lista de cidades/estados ou null se não houver dados
  Future<List<String>?> getCities(int countryId) async {
    return await presenter.getStates(countryId);
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
