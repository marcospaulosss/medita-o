import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/authenticate_google_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/authenticate_google_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/register_response.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client_api.g.dart';

@RestApi()
abstract class ClientApi {
  factory ClientApi(EnvironmentManager environmentManager) {
    var dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));

    return _ClientApi(
      dio,
      baseUrl: environmentManager.apiBaseUrl,
    );
  }

  /// - [Social] : Cliente de autenticação social
  /// Solicita a autenticação do usuário utilizando o Google
  @POST('/auth/google')
  Future<AuthenticateGoogleResponse> authGoogle(
      @Body() AuthenticateGoogleRequest token);

  /// - [Auth] : Cliente de autenticação
  /// Solicita a autenticação do usuário utilizando email e senha no servidor
  @POST('/login')
  Future<RegisterResponse> login(
      @Body() AuthRequest body);

  /// - [Register] : Cliente de criação de conta
  /// Solicita a criação de uma conta no servidor
  @POST('/register')
  Future<RegisterResponse> register(
      @Body() AuthRequest body);
}
