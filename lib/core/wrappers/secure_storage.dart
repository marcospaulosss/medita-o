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
      setUserId("0"),
      setUserName(""),
      setUserEmail(""),
      setGoogleId(""),
    ]);
  }

  //region - Chaves
  static const _tokenAPI = "token";
  static const _isLogged = "isLogged";
  static const _userId = "userId";
  static const _userName = "userName";
  static const _userEmail = "userEmail";
  static const _googleId = "googleId";

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

  /// id do usuário
  Future<String> get userId async => await read(key: _userId) ?? "";

  /// Define o id do usuário
  Future<void> setUserId(String userId) async {
    await write(key: _userId, value: userId);
  }

  /// nome do usuário
  Future<String> get userName async => await read(key: _userName) ?? "";

  /// Define o nome do usuário
  Future<void> setUserName(String userName) async {
    await write(key: _userName, value: userName);
  }

  /// email do usuário
  Future<String> get userEmail async => await read(key: _userEmail) ?? "";

  /// Define o email do usuário
  Future<void> setUserEmail(String userEmail) async {
    await write(key: _userEmail, value: userEmail);
  }

  /// id do google
  Future<String> get googleId async => await read(key: _googleId) ?? "";

  /// Define o id do google
  Future<void> setGoogleId(String googleId) async {
    await write(key: _googleId, value: googleId);
  }
}
