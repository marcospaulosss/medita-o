import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/core/routers/auth_guard.dart';

/// O que é executado ao encerrar uma rota.
typedef OnCloseRoute = void Function(dynamic value);

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashScreenRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: HomeRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: RegisterSuccessRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: CameraRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: MeditateInfoRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: FiveMinutesRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: InYourTimeRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: GuidedMeditationRoute.page, guards: [AuthGuard()]),
        AutoRoute(
            page: GuidedMeditationProgramRoute.page, guards: [AuthGuard()]),
      ];

  /// Direciona para a tela selecionada e remove a tela anterior
  void goToReplace(PageRouteInfo route) {
    replace(route);
  }

  /// Direciona para a tela selecionada
  void goTo(PageRouteInfo route, {OnCloseRoute? onClose}) {
    void onCloseHandler(value) => onClose?.call(value);

    push(route).then(onCloseHandler);
  }
}
