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
/// Esta é a primeira tela que o usuário visualiza ao abrir o aplicativo pela primeira vez.
/// Implementa o padrão MVP (Model-View-Presenter) através do [WelcomeViewContract]
/// e utiliza injeção de dependências para gerenciar suas dependências.
///
/// Características principais:
/// * Design minimalista e acolhedor
/// * Suporte completo a internacionalização
/// * Implementação de acessibilidade
/// * Feedback visual durante carregamentos
///
/// Componentes visuais:
/// * Logo do aplicativo centralizado
/// * Título de boas-vindas personalizado
/// * Mensagem destacando que o app é gratuito
/// * Botão de entrada com feedback visual
///
/// A tela utiliza:
/// * [AutoRoute] para navegação type-safe
/// * [AuthenticationStrings] para internacionalização
/// * [BackgroundDefault] para estilização consistente
/// * [AppColors] para paleta de cores padronizada
@RoutePage()
class WelcomeView extends StatefulWidget {
  /// Cria uma instância imutável de [WelcomeView].
  ///
  /// Esta tela não aceita parâmetros externos pois é a tela inicial
  /// do fluxo de autenticação.
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

/// Estado interno da tela de boas-vindas.
///
/// Esta classe implementa [WelcomeViewContract] para estabelecer
/// a comunicação bidirecional com o presenter, seguindo o padrão MVP.
///
/// Responsabilidades:
/// * Gerenciar o ciclo de vida da view
/// * Construir e atualizar a interface do usuário
/// * Responder a interações do usuário
/// * Manter o estado visual da tela
class _WelcomeViewState extends State<WelcomeView>
    implements WelcomeViewContract {
  /// Presenter responsável pela lógica de negócios.
  ///
  /// Obtido através de injeção de dependências usando [resolve].
  /// Gerencia todas as operações não-visuais da tela.
  final Presenter _presenter = resolve<WelcomePresenter>();

  /// Indica se há uma operação de carregamento em andamento.
  ///
  /// Quando true, exibe um indicador de progresso e desabilita interações.
  bool _isLoading = false;

  /// Padding horizontal padrão aplicado aos elementos da tela.
  ///
  /// Valor fixo de 24.0 pixels para manter consistência visual.
  static const double _horizontalPadding = 24.0;

  /// Altura fixa da imagem do logo do aplicativo.
  ///
  /// Mantém as proporções da imagem consistentes em diferentes dispositivos.
  static const double _imageHeight = 200.0;

  /// Espaçamento vertical padrão entre elementos principais.
  static const double _verticalSpacing = 30.0;

  /// Espaçamento vertical reduzido para elementos relacionados.
  static const double _smallVerticalSpacing = 5.0;

  /// Padding vertical aplicado ao botão de entrada.
  static const double _buttonVerticalPadding = 16.0;

  /// Raio da borda do botão de entrada.
  static const double _buttonBorderRadius = 12.0;

  /// Tamanho de fonte padrão para textos informativos.
  static const double _textSize = 20.0;

  /// Tamanho de fonte específico para o texto do botão.
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

  /// Estilo de texto base para conteúdo informativo.
  ///
  /// Características:
  /// * Tamanho de fonte padronizado [_textSize]
  /// * Cor cinza suave [AppColors.dimGray]
  /// * Peso da fonte light para melhor legibilidade
  TextStyle get _defaultTextStyle => const TextStyle(
        fontSize: _textSize,
        color: AppColors.dimGray,
        fontWeight: FontWeight.w300,
      );

  /// Estilo de texto para elementos destacados.
  ///
  /// Características:
  /// * Cor azul vibrante [AppColors.germanderSpeedwell]
  /// * Peso da fonte bold para maior destaque
  /// * Mantém o tamanho de fonte do estilo base
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
  /// Características:
  /// * Utiliza a imagem [AppImages.balloon] como logo
  /// * Mantém altura fixa definida por [_imageHeight]
  /// * Implementa semântica para acessibilidade
  /// * Centraliza automaticamente na tela
  ///
  /// Returns:
  ///   Um [Widget] semanticamente acessível contendo o logo
  Widget _buildLogo() {
    return Semantics(
      label: 'Logo 5 Minutos Eu Medito',
      child: Image.asset(
        AppImages.balloon,
        height: _imageHeight,
      ),
    );
  }

  /// Constrói o título principal da tela.
  ///
  /// Características:
  /// * Texto centralizado
  /// * Utiliza [_defaultTextStyle] para consistência visual
  /// * Suporte completo a internacionalização
  ///
  /// Parameters:
  ///   strings: Provedor de strings localizadas para o módulo de autenticação
  ///
  /// Returns:
  ///   Um [RichText] centralizado contendo o título localizado
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

  /// Constrói o subtítulo com destaque para gratuidade.
  ///
  /// Características:
  /// * Combina texto normal e destacado
  /// * Centralização automática
  /// * Suporte a internacionalização
  /// * Estilização diferenciada para parte destacada
  ///
  /// Parameters:
  ///   strings: Provedor de strings localizadas para o módulo de autenticação
  ///
  /// Returns:
  ///   Um [RichText] com estilização composta para o subtítulo
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

  /// Constrói o botão principal de entrada.
  ///
  /// Características:
  /// * Ocupa toda a largura disponível
  /// * Cor de fundo personalizada
  /// * Feedback visual durante carregamento
  /// * Bordas arredondadas
  /// * Texto em negrito
  ///
  /// Comportamento:
  /// * Desabilita durante carregamento
  /// * Utiliza [_presenter] para navegação
  /// * Suporta internacionalização
  ///
  /// Parameters:
  ///   strings: Provedor de strings localizadas para o módulo de autenticação
  ///
  /// Returns:
  ///   Um [Widget] de botão estilizado e responsivo
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
