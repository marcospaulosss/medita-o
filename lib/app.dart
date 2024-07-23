import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/shared/components/bottom_nav_bar.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/custom_navigator_observer.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  App({super.key});

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
        _showBottomNavigationBar = _shouldShowBottomNavigationBar(routeName);
      });
    });
  }

  bool _shouldShowBottomNavigationBar(String routeName) {
    // Defina aqui as rotas que devem exibir o bottomNavigationBar
    const routesWithBottomNavigationBar = [
      HomeRoute.name,
    ];
    return routesWithBottomNavigationBar.contains(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            body: child!,
            bottomNavigationBar: _showBottomNavigationBar
                ? BottomNavBar(
                    routeName: routeName,
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
      ],
      localizationsDelegates: const [
        CommonStrings.delegate,
        AuthenticationStrings.delegate,
        SharedStrings.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
