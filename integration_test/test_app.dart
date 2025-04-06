import 'package:flutter/material.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';

class TestApp extends StatelessWidget {
  final AppRouter router;
  final AnalyticsManager analyticsManager;
  final SecureStorage secureStorage;

  const TestApp({
    super.key,
    required this.router,
    required this.analyticsManager,
    required this.secureStorage,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        ...AuthenticationStrings.localizationsDelegates,
      ],
      supportedLocales: AuthenticationStrings.supportedLocales,
      home: WelcomeView(),
    );
  }
} 