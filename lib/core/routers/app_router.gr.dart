// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_view.dart'
    as _i4;
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_view.dart'
    as _i7;
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_view.dart'
    as _i6;
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_view.dart'
    as _i3;
import 'package:cinco_minutos_meditacao/modules/common/screens/splash_screen/splash_screen_view.dart'
    as _i8;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_view.dart'
    as _i2;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_model.dart'
    as _i11;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_view.dart'
    as _i5;
import 'package:cinco_minutos_meditacao/shared/components/camera_view.dart'
    as _i1;
import 'package:flutter/material.dart' as _i10;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    CameraRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CameraView(),
      );
    },
    FiveMinutesRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.FiveMinutesView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginView(),
      );
    },
    MeditateInfoRoute.name: (routeData) {
      final args = routeData.argsAs<MeditateInfoRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.MeditateInfoView(
          key: args.key,
          model: args.model,
        ),
      );
    },
    RegisterSuccessRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RegisterSuccessView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.RegisterView(),
      );
    },
    SplashScreenRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SplashScreenView(),
      );
    },
  };
}

/// generated route for
/// [_i1.CameraView]
class CameraRoute extends _i9.PageRouteInfo<void> {
  const CameraRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CameraRoute.name,
          initialChildren: children,
        );

  static const String name = 'CameraRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.FiveMinutesView]
class FiveMinutesRoute extends _i9.PageRouteInfo<void> {
  const FiveMinutesRoute({List<_i9.PageRouteInfo>? children})
      : super(
          FiveMinutesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FiveMinutesRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeView]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginView]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MeditateInfoView]
class MeditateInfoRoute extends _i9.PageRouteInfo<MeditateInfoRouteArgs> {
  MeditateInfoRoute({
    _i10.Key? key,
    required _i11.MeditateInfoModel model,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          MeditateInfoRoute.name,
          args: MeditateInfoRouteArgs(
            key: key,
            model: model,
          ),
          initialChildren: children,
        );

  static const String name = 'MeditateInfoRoute';

  static const _i9.PageInfo<MeditateInfoRouteArgs> page =
      _i9.PageInfo<MeditateInfoRouteArgs>(name);
}

class MeditateInfoRouteArgs {
  const MeditateInfoRouteArgs({
    this.key,
    required this.model,
  });

  final _i10.Key? key;

  final _i11.MeditateInfoModel model;

  @override
  String toString() {
    return 'MeditateInfoRouteArgs{key: $key, model: $model}';
  }
}

/// generated route for
/// [_i6.RegisterSuccessView]
class RegisterSuccessRoute extends _i9.PageRouteInfo<void> {
  const RegisterSuccessRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RegisterSuccessRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterSuccessRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.RegisterView]
class RegisterRoute extends _i9.PageRouteInfo<void> {
  const RegisterRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SplashScreenView]
class SplashScreenRoute extends _i9.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SplashScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashScreenRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
