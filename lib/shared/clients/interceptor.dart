import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// Interceptador usado para adicionar o token e validar erro de autenticação.
class TokenInterceptor extends Interceptor {
  /// Router da aplicação.
  final AppRouter _appRouter;

  /// Utilitário para armazenamento seguro de dados.
  final SecureStorage _secureStorage;

  /// Cria o interceptador usado para adicionar o token e validar erro de autenticação.
  TokenInterceptor(this._appRouter, this._secureStorage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.tokenAPI;

    options.headers["Authorization"] = "Bearer $token";

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    final statusCode = response?.statusCode;

    if (response == null || statusCode != 401) {
      return super.onError(err, handler);
    }

    debugPrint("Token is not valid. Redirecting to login.");

    _secureStorage.setAllToNull();

    _appRouter.goToReplace(const LoginRoute());

    return super.onError(err, handler);
  }
}
