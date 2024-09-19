import 'dart:async';
import 'dart:io';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/analytics/events.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';

import 'guided_meditation_contract.dart';

class GuidedMeditationRepository implements Repository {
  /// Analytics
  final AnalyticsManager _analytics;

  /// - [analytics] : Analytics
  /// construtor
  GuidedMeditationRepository(this._analytics);

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(MeditateEvents.informationMethodScreenOpened);
  }
}
