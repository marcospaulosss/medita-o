import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/shared/strings/localization/meditometer_strings.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_contract.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_model.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_presenter.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class ShareView extends StatefulWidget {
  /// Construtor
  const ShareView({
    super.key,
  });

  @override
  State<ShareView> createState() => ShareViewState();
}

@visibleForTesting
class ShareViewState extends State<ShareView> implements ShareViewContract {
  /// Presenter
  Presenter presenter = resolve<SharePresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  /// Model para contrução da tela
  late ShareModel model = ShareModel();
  final controller = PageController(viewportFraction: 1.0);
  final pages = List.generate(
      6,
      (index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade300,
            ),
            child: Container(
              height: 280,
              child: Center(
                  child: Text(
                "Page $index",
                style: TextStyle(color: Colors.indigo),
              )),
            ),
          ));

  int _currentIndex = 0;
  final List<String> imgList = [
    AppImages.balloon,
    AppImages.banner,
    AppImages.favorite,
  ];

  @override
  void initState() {
    presenter.bindView(this);
    presenter.initPresenter();

    super.initState();
  }

  @override
  void dispose() {
    presenter.unbindView();
    controller.dispose();

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
    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: Column(
          children: [
            buildClose(context),
            const SizedBox(height: 38),
            buildTitle(),
            const SizedBox(height: 38),
            buildCarrosel(),
            const SizedBox(height: 38),
            IconLabelButton(
              onTap: () => presenter.socialShare(),
              decoration: BoxDecoration(
                color: AppColors.germanderSpeedwell,
                borderRadius: BorderRadius.circular(12),
              ),
              icon: const Icon(
                Icons.share_outlined,
                color: AppColors.white,
                size: 25,
              ),
              label: Text(
                MeditometerStrings.of(context).share,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              width: double.infinity,
              height: 43,
              spaceBetween: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCarrosel() {
    return Column(
      children: [
        SizedBox(
          height: 370,
          child: PageView.builder(
            controller: controller,
            itemBuilder: (_, index) {
              return pages[index % pages.length];
            },
          ),
        ),
        const SizedBox(height: 40),
        SmoothPageIndicator(
          controller: controller,
          count: pages.length,
          effect: CustomizableEffect(
            spacing: 12,
            dotDecoration: DotDecoration(
              width: 15,
              height: 15,
              color: AppColors.white,
              dotBorder: const DotBorder(
                padding: 1,
                width: 1,
                color: AppColors.frankBlue,
              ),
              borderRadius: BorderRadius.circular(16),
              verticalOffset: 0,
            ),
            activeDotDecoration: DotDecoration(
              width: 15,
              height: 15,
              color: AppColors.yellow,
              borderRadius: BorderRadius.circular(25),
              dotBorder: const DotBorder(
                padding: 1,
                width: 2,
                color: AppColors.yellow,
              ),
            ),
          ),
          onDotClicked: (index) {
            controller.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
        ),
      ],
    );
  }

  Column buildTitle() {
    return const Column(
      children: [
        Text(
          "Compartilhe",
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            fontFamily: 'Hebbo',
          ),
        ),
        Text(
          "Sua meditação do dia!",
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.w400,
            fontFamily: 'Hebbo',
          ),
        ),
      ],
    );
  }

  /// Fecha a tela
  Row buildClose(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(
            Icons.close,
            color: AppColors.white,
            size: 28,
          ),
          onPressed: () {
            AutoRouter.of(context).pop();
          },
        ),
      ],
    );
  }

  /// Mostra o estado de carregamento
  @override
  void showLoading() {
    stateController.showLoadingState();
  }

  /// Mostra o estado normal
  @override
  void showNormalState(ShareModel response) {
    setState(() {
      model = response;
    });
    stateController.showNormalState();
  }

  /// Mostra o estado de erro
  @override
  void showError(String message) {
    messageError = message;
    stateController.showErrorState();
  }
}
