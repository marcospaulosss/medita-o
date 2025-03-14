// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_view.dart'
    as _i9;
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_view.dart'
    as _i14;
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_view.dart'
    as _i13;
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_view.dart'
    as _i1;
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_view.dart'
    as _i7;
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_view.dart'
    as _i12;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_view.dart'
    as _i3;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_view.dart'
    as _i4;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_view.dart'
    as _i6;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_view.dart'
    as _i5;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_view.dart'
    as _i8;
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_view.dart'
    as _i10;
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_view.dart'
    as _i11;
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_model.dart'
    as _i18;
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_view.dart'
    as _i15;
import 'package:cinco_minutos_meditacao/shared/components/camera_view.dart'
    as _i2;
import 'package:flutter/material.dart' as _i17;

abstract class $AppRouter extends _i16.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    CalendarRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CalendarView(),
      );
    },
    CameraRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CameraView(),
      );
    },
    DonationRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DonationView(),
      );
    },
    FiveMinutesRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.FiveMinutesView(),
      );
    },
    GuidedMeditationProgramRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.GuidedMeditationProgramView(),
      );
    },
    GuidedMeditationRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.GuidedMeditationView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomeView(),
      );
    },
    InYourTimeRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.InYourTimeView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.LoginView(),
      );
    },
    MeditateInfoRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.MeditateInfoView(),
      );
    },
    MeditometerRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.MeditometerView(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ProfileView(),
      );
    },
    RegisterSuccessRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.RegisterSuccessView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.RegisterView(),
      );
    },
    ShareRoute.name: (routeData) {
      final args = routeData.argsAs<ShareRouteArgs>();
      return _i16.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.ShareView(
          key: args.key,
          params: args.params,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CalendarView]
class CalendarRoute extends _i16.PageRouteInfo<void> {
  const CalendarRoute({List<_i16.PageRouteInfo>? children})
      : super(
          CalendarRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalendarRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CameraView]
class CameraRoute extends _i16.PageRouteInfo<void> {
  const CameraRoute({List<_i16.PageRouteInfo>? children})
      : super(
          CameraRoute.name,
          initialChildren: children,
        );

  static const String name = 'CameraRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DonationView]
class DonationRoute extends _i16.PageRouteInfo<void> {
  const DonationRoute({List<_i16.PageRouteInfo>? children})
      : super(
          DonationRoute.name,
          initialChildren: children,
        );

  static const String name = 'DonationRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i4.FiveMinutesView]
class FiveMinutesRoute extends _i16.PageRouteInfo<void> {
  const FiveMinutesRoute({List<_i16.PageRouteInfo>? children})
      : super(
          FiveMinutesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FiveMinutesRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i5.GuidedMeditationProgramView]
class GuidedMeditationProgramRoute extends _i16.PageRouteInfo<void> {
  const GuidedMeditationProgramRoute({List<_i16.PageRouteInfo>? children})
      : super(
          GuidedMeditationProgramRoute.name,
          initialChildren: children,
        );

  static const String name = 'GuidedMeditationProgramRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i6.GuidedMeditationView]
class GuidedMeditationRoute extends _i16.PageRouteInfo<void> {
  const GuidedMeditationRoute({List<_i16.PageRouteInfo>? children})
      : super(
          GuidedMeditationRoute.name,
          initialChildren: children,
        );

  static const String name = 'GuidedMeditationRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomeView]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute({List<_i16.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i8.InYourTimeView]
class InYourTimeRoute extends _i16.PageRouteInfo<void> {
  const InYourTimeRoute({List<_i16.PageRouteInfo>? children})
      : super(
          InYourTimeRoute.name,
          initialChildren: children,
        );

  static const String name = 'InYourTimeRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i9.LoginView]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i10.MeditateInfoView]
class MeditateInfoRoute extends _i16.PageRouteInfo<void> {
  const MeditateInfoRoute({List<_i16.PageRouteInfo>? children})
      : super(
          MeditateInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'MeditateInfoRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i11.MeditometerView]
class MeditometerRoute extends _i16.PageRouteInfo<void> {
  const MeditometerRoute({List<_i16.PageRouteInfo>? children})
      : super(
          MeditometerRoute.name,
          initialChildren: children,
        );

  static const String name = 'MeditometerRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ProfileView]
class ProfileRoute extends _i16.PageRouteInfo<void> {
  const ProfileRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i13.RegisterSuccessView]
class RegisterSuccessRoute extends _i16.PageRouteInfo<void> {
  const RegisterSuccessRoute({List<_i16.PageRouteInfo>? children})
      : super(
          RegisterSuccessRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterSuccessRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i14.RegisterView]
class RegisterRoute extends _i16.PageRouteInfo<void> {
  const RegisterRoute({List<_i16.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i16.PageInfo<void> page = _i16.PageInfo<void>(name);
}

/// generated route for
/// [_i15.ShareView]
class ShareRoute extends _i16.PageRouteInfo<ShareRouteArgs> {
  ShareRoute({
    _i17.Key? key,
    required _i18.ShareModel params,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          ShareRoute.name,
          args: ShareRouteArgs(
            key: key,
            params: params,
          ),
          initialChildren: children,
        );

  static const String name = 'ShareRoute';

  static const _i16.PageInfo<ShareRouteArgs> page =
      _i16.PageInfo<ShareRouteArgs>(name);
}

class ShareRouteArgs {
  const ShareRouteArgs({
    this.key,
    required this.params,
  });

  final _i17.Key? key;

  final _i18.ShareModel params;

  @override
  String toString() {
    return 'ShareRouteArgs{key: $key, params: $params}';
  }
}
