import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Gerenciador de ambiente.
class EnvironmentManager {
  /// Retorna o valor de uma variável de ambiente.
  ///
  /// - [variable] representa o nome da variável.
  ///
  String get(String variable) => dotenv.get(variable);

  /// Retorna o valor da base url.
  String get apiBaseUrl => dotenv.get("API_BASE_URL");

  /// Retorna a chave para utilizar google maps android
  String get isProduction => dotenv.get("PRODUCTION");
}
