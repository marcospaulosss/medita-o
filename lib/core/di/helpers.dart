import 'package:get_it/get_it.dart';

/// Factory que recebe um parâmetro dinânico.
typedef FactoryWithParameter<T extends Object> = T Function(dynamic parameter);

/// Realiza o registro de um singleton.
///
/// [instance] representa a instância do singleton.
///
void registerSingleton<T extends Object>(T instance) {
  GetIt.I.registerSingleton<T>(instance);
}

/// Realiza o registro de uma factory.
///
/// [factory] representa a factory que será registrada.
///
void registerFactory<T extends Object>(FactoryFunc<T> factory) {
  GetIt.I.registerFactory<T>(factory);
}

/// Realiza o registro de uma factory que recebe um parâmetro dinânico.
///
/// [factory] representa a factory que será registrada.
///
void registerFactoryWithParameter<T extends Object>(
    FactoryWithParameter<T> factory) {
  GetIt.I.registerFactoryParam<T, dynamic, dynamic>(
      (parameter, _) => factory(parameter));
}

/// Resolve uma determinada dependência e retorna a instância.
///
/// [parameter] representa o parâmetro dinâmico, se houver, que deve ser passado para a instância.
///
T resolve<T extends Object>({parameter}) => GetIt.I.get<T>(param1: parameter);
