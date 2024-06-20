import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  /// Instância do [FlutterSecureStorage].
  static const _flutterSecureStorage = FlutterSecureStorage();

  /// Configurações do [FlutterSecureStorage] para Android.
  static const AndroidOptions _androidOptions = AndroidOptions();

  /// Configurações do [FlutterSecureStorage] para iOS.
  static const IOSOptions _iosOptions = IOSOptions();

  /// region - Métodos de leitura e escrita
  static Future<String?> read({required String key}) async {
    return await _flutterSecureStorage.read(
      key: key,
      iOptions: _iosOptions,
      aOptions: _androidOptions,
    );
  }

  /// Escreve um valor no [FlutterSecureStorage].
  static Future<void> write({required String key, String? value}) async {
    if (value == null) {
      return await _flutterSecureStorage.delete(
        key: key,
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      );
    }

    await _flutterSecureStorage.write(
      key: key,
      value: value,
      iOptions: _iosOptions,
      aOptions: _androidOptions,
    );
  }

  /// Limpa todos os dados armazenados.
  Future setAllToNull() async {
    return await Future.wait([
      setTokenAPI(""),
      setIsLogged(false),
    ]);
  }

  //region - Chaves
  static const _tokenAPI = "token";
  static const _isLogged = "isLogged";

  /// Token de autenticação da api
  Future<String> get tokenAPI async => await read(key: _tokenAPI) ?? "";

  /// Define o token de autenticação da api
  Future<void> setTokenAPI(String tokenAPI) async {
    await write(key: _tokenAPI, value: tokenAPI.toString());
  }

  /// Verifica se o usuário está logado
  Future<bool> get isLogged async => await read(key: _isLogged) == "true";

  /// Define se o usuário está logado
  Future<void> setIsLogged(bool isLogged) async {
    await write(key: _isLogged, value: isLogged.toString());
  }
}
