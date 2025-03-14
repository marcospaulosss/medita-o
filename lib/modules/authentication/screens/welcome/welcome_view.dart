import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/components/background_default.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';

/// Widget que representa a tela de boas-vindas do aplicativo.
///
/// Esta é a primeira tela que o usuário vê ao abrir o aplicativo.
/// Ela contém:
/// * Uma imagem de logo
/// * Um título de boas-vindas
/// * Uma mensagem destacando que o app é gratuito
/// * Um botão para entrar no aplicativo
///
/// A tela utiliza o sistema de rotas [AutoRoute] para navegação e
/// suporta internacionalização através de [AuthenticationStrings].
@RoutePage()
class WelcomeView extends StatefulWidget {
  /// Cria uma instância imutável de [WelcomeView].
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView>
    implements WelcomeViewContract {
  /// Presenter responsável pela lógica de negócios
  final Presenter _presenter = resolve<WelcomePresenter>();

  /// Flag que indica se está carregando
  bool _isLoading = false;

  /// Padding horizontal padrão da tela.
  static const double _horizontalPadding = 24.0;

  /// Altura da imagem do logo.
  static const double _imageHeight = 200.0;

  /// Espaçamento vertical padrão entre elementos.
  static const double _verticalSpacing = 30.0;

  /// Espaçamento vertical menor entre elementos.
  static const double _smallVerticalSpacing = 5.0;

  /// Padding vertical do botão de entrar.
  static const double _buttonVerticalPadding = 16.0;

  /// Raio da borda do botão de entrar.
  static const double _buttonBorderRadius = 12.0;

  /// Tamanho padrão do texto para títulos e mensagens.
  static const double _textSize = 20.0;

  /// Tamanho do texto do botão.
  static const double _buttonTextSize = 19.0;

  /// Flag que indica se o presenter já foi inicializado
  bool _isPresenterInitialized = false;

  @override
  void initState() {
    _presenter.bindView(this);
    _presenter.onOpenScreen();

    super.initState();
  }

  @override
  void dispose() {
    _presenter.unbindView();
    super.dispose();
  }

  /// Estilo de texto padrão usado nos textos da tela.
  ///
  /// Aplica:
  /// * Tamanho de fonte [_textSize]
  /// * Cor cinza [AppColors.dimGray]
  /// * Peso da fonte light (300)
  TextStyle get _defaultTextStyle => const TextStyle(
        fontSize: _textSize,
        color: AppColors.dimGray,
        fontWeight: FontWeight.w300,
      );

  /// Estilo de texto para destacar partes importantes do texto.
  ///
  /// Aplica:
  /// * Cor azul [AppColors.germanderSpeedwell]
  /// * Peso da fonte bold (700)
  TextStyle get _highlightTextStyle => const TextStyle(
        color: AppColors.germanderSpeedwell,
        fontWeight: FontWeight.w700,
      );

  @override
  Widget build(BuildContext context) {
    final strings = AuthenticationStrings.of(context);

    return Stack(
      children: [
        Scaffold(
          body: BackgroundDefault(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: _verticalSpacing),
                    _buildTitle(strings),
                    const SizedBox(height: _smallVerticalSpacing),
                    _buildSubtitle(strings),
                    const SizedBox(height: _verticalSpacing),
                    _buildEnterButton(strings),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isLoading)
          const ColoredBox(
            color: Colors.black26,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  /// Constrói o widget do logo do aplicativo.
  ///
  /// Utiliza [AppImages.balloon] como imagem e aplica semântica
  /// para acessibilidade.
  ///
  /// Returns:
  ///   Um [Widget] contendo a imagem do logo com altura definida
  ///   por [_imageHeight].
  Widget _buildLogo() {
    return Semantics(
      label: 'Logo 5 Minutos Eu Medito',
      child: Image.asset(
        AppImages.balloon,
        height: _imageHeight,
      ),
    );
  }

  /// Constrói o título principal da tela de boas-vindas.
  ///
  /// Utiliza [AuthenticationStrings] para internacionalização.
  ///
  /// Parameters:
  ///   strings: Instância de [AuthenticationStrings] para acessar
  ///           as strings traduzidas.
  ///
  /// Returns:
  ///   Um [Widget] de texto rico centralizado com o título.
  Widget _buildTitle(AuthenticationStrings strings) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: _defaultTextStyle,
        children: [
          TextSpan(text: strings.welcomeTitle),
        ],
      ),
    );
  }

  /// Constrói o subtítulo da tela com destaque para "100% gratuito".
  ///
  /// Combina texto normal com texto destacado usando [_highlightTextStyle].
  ///
  /// Parameters:
  ///   strings: Instância de [AuthenticationStrings] para acessar
  ///           as strings traduzidas.
  ///
  /// Returns:
  ///   Um [Widget] de texto rico centralizado com o subtítulo.
  Widget _buildSubtitle(AuthenticationStrings strings) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: _defaultTextStyle,
        children: [
          TextSpan(
            text: strings.welcomeSubtitle,
            style: _highlightTextStyle,
          ),
          TextSpan(text: '. ${strings.welcomeMessage}'),
        ],
      ),
    );
  }

  /// Constrói o botão de entrada do aplicativo.
  ///
  /// Ao ser pressionado, navega para [LoginRoute] usando [AutoRouter].
  ///
  /// Parameters:
  ///   strings: Instância de [AuthenticationStrings] para acessar
  ///           as strings traduzidas.
  ///
  /// Returns:
  ///   Um [Widget] de botão que ocupa toda a largura disponível.
  Widget _buildEnterButton(AuthenticationStrings strings) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : () => _presenter.navigateToLogin(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7CC5FF),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: _buttonVerticalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_buttonBorderRadius),
          ),
        ),
        child: Text(
          strings.enter,
          style: const TextStyle(
            fontSize: _buttonTextSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
