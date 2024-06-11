import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/authenticate_google_request.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'social_client_api.g.dart';

@RestApi()
abstract class SocialClientApi {
  factory SocialClientApi(EnvironmentManager environmentManager) {
    var dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));

    return _SocialClientApi(
      dio,
      baseUrl: environmentManager.apiBaseUrl,
    );
  }

  @POST('/auth/google')
  Future<void> authGoogle(@Body() AuthenticateGoogleRequest token);
}
