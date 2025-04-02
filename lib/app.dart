import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/shared/strings/localization/calendar_strings.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/shared/strings/localization/meditometer_strings.dart';
import 'package:cinco_minutos_meditacao/modules/share/shared/strings/localization/share_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/bottom_nav_bar.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/bottom_navigation_bar.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/custom_navigator_observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'shared/strings/localization/shared_strings.dart';

class App extends StatefulWidget {
  const App({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// Inicializa o AppRouter
  final _appRouter = resolve<AppRouter>();

  /// Controla a exibição do bottomNavigationBar
  bool _showBottomNavigationBar = false;

  /// Nome da rota atual
  String routeName = '';

  @override
  void initState() {
    super.initState();
    _appRouter.config(
      navigatorObservers: () => [
        App.observer,
        CustomNavigatorObserver(onRouteChanged: _onRouteChanged),
      ],
    );
  }

  void _onRouteChanged(String routeName) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        this.routeName = routeName;
        _showBottomNavigationBar = shouldShowBottomNavigationBar(routeName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: Scaffold(
            body: child!,
            backgroundColor: AppColors.azureishWhite,
            bottomNavigationBar: _showBottomNavigationBar
                ? BottomNavBar(
                    routeName: routeName,
                    router: _appRouter,
                  )
                : null,
          ),
        );
      },
      theme: ThemeData(
        brightness: Brightness.light,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        fontFamily: 'Heebo',
      ),
      routerConfig: _appRouter.config(
        navigatorObservers: () => [
          App.observer,
          CustomNavigatorObserver(onRouteChanged: _onRouteChanged),
        ],
      ),
      supportedLocales: const [
        Locale('pt', ''),
        Locale('es', ''),
        Locale('en', ''),
        Locale('it', ''),
        Locale('de', ''),
        Locale('fr', ''),
      ],
      localizationsDelegates: const [
        CommonStrings.delegate,
        AuthenticationStrings.delegate,
        SharedStrings.delegate,
        MeditateStrings.delegate,
        MeditometerStrings.delegate,
        CalendarStrings.delegate,
        ShareStrings.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
