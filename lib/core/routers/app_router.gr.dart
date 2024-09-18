// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_view.dart'
    as _i6;
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_view.dart'
    as _i9;
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_view.dart'
    as _i8;
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_view.dart'
    as _i4;
import 'package:cinco_minutos_meditacao/modules/common/screens/splash_screen/splash_screen_view.dart'
    as _i10;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_view.dart'
    as _i2;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_view.dart'
    as _i3;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_view.dart'
    as _i5;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_view.dart'
    as _i7;
import 'package:cinco_minutos_meditacao/shared/components/camera_view.dart'
    as _i1;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    CameraRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CameraView(),
      );
    },
    FiveMinutesRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.FiveMinutesView(),
      );
    },
    GuidedMeditationRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.GuidedMeditationView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeView(),
      );
    },
    InYourTimeRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.InYourTimeView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginView(),
      );
    },
    MeditateInfoRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.MeditateInfoView(),
      );
    },
    RegisterSuccessRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.RegisterSuccessView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.RegisterView(),
      );
    },
    SplashScreenRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SplashScreenView(),
      );
    },
  };
}

/// generated route for
/// [_i1.CameraView]
class CameraRoute extends _i11.PageRouteInfo<void> {
  const CameraRoute({List<_i11.PageRouteInfo>? children})
      : super(
          CameraRoute.name,
          initialChildren: children,
        );

  static const String name = 'CameraRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.FiveMinutesView]
class FiveMinutesRoute extends _i11.PageRouteInfo<void> {
  const FiveMinutesRoute({List<_i11.PageRouteInfo>? children})
      : super(
          FiveMinutesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FiveMinutesRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GuidedMeditationView]
class GuidedMeditationRoute extends _i11.PageRouteInfo<void> {
  const GuidedMeditationRoute({List<_i11.PageRouteInfo>? children})
      : super(
          GuidedMeditationRoute.name,
          initialChildren: children,
        );

  static const String name = 'GuidedMeditationRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeView]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i5.InYourTimeView]
class InYourTimeRoute extends _i11.PageRouteInfo<void> {
  const InYourTimeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          InYourTimeRoute.name,
          initialChildren: children,
        );

  static const String name = 'InYourTimeRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginView]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MeditateInfoView]
class MeditateInfoRoute extends _i11.PageRouteInfo<void> {
  const MeditateInfoRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MeditateInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'MeditateInfoRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i8.RegisterSuccessView]
class RegisterSuccessRoute extends _i11.PageRouteInfo<void> {
  const RegisterSuccessRoute({List<_i11.PageRouteInfo>? children})
      : super(
          RegisterSuccessRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterSuccessRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i9.RegisterView]
class RegisterRoute extends _i11.PageRouteInfo<void> {
  const RegisterRoute({List<_i11.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SplashScreenView]
class SplashScreenRoute extends _i11.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SplashScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashScreenRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
