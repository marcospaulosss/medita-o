import 'dart:async';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/share/analytics/events.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/share_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

import 'share_contract.dart';

class ShareRepository implements Repository {
  /// Analytics
  final AnalyticsManager _analytics;

  /// Cliente de autenticação social
  final ClientApi _clientApi;

  /// Erro customizado
  final CustomError _error;

  /// Secure Storage
  final SecureStorage _secureStorage;

  /// - [analytics] : Analytics
  /// - [clientApi] : Cliente de autenticação social
  /// - [error] : Erro customizado
  /// - [secureStorage] : Secure Storage
  /// construtor
  ShareRepository(
      this._analytics, this._clientApi, this._error, this._secureStorage);

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(ShareEvents.shareScreenOpened);
  }

  /// Busca a imagem para compartilhamento nas redes sociais
  @override
  Future<(ShareResponse?, CustomError?)> getImages() async {
    try {
      ShareResponse shareResponse = await _clientApi.getImagesShare();
      return (shareResponse, null);
    } catch (e) {
      return (
        null,
        _error.sendErrorToCrashlytics(
            code: ErrorCodes.socialShareError, stackTrace: StackTrace.current)
      );
    }
  }
}
