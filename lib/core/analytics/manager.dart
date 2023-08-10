import 'package:cinco_minutos_meditacao/core/analytics/event.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Gerenciador de eventos de analytics.
class AnalyticsManager {
  /// Utilitário para armazenamento seguro de dados.
  // final SecureStorage _secureStorage;

  /// Cria o gerenciador de eventos de analytics.
  // AnalyticsManager(this._secureStorage);
  AnalyticsManager();

  /// Envia um determinado evento de analytics.
  ///
  /// [event] representa o evento de analytics a ser enviado.
  ///
  void sendEvent(AnalyticsEvent event) async {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    final parameters = event.parameters ?? {};
    // final userId = await _secureStorage.getOnboardingId();

    // if (userId != null) {
    //   parameters["user"] = userId.toString();
    // }

    analytics.logEvent(
      name: event.name,
      parameters: parameters,
    );

    debugPrint(
        "Evento '${event.name}' enviado para o Firebase com os parâmetros '$parameters'");
  }
}
