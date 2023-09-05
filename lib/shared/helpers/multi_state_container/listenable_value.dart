import 'dart:async';

import 'package:flutter/material.dart';

/// Objeto cujo o valor pode ser monitorado.
class ListenableValue<Type> {

  /// Controlador do stream associado ao valor.
  final _controller = StreamController<Type>.broadcast();

  /// Valor atual.
  Type _currentValue;

  /// Cria o objeto cujo o valor pode ser monitorado.
  ListenableValue(this._currentValue);

  /// Retorna o valor.
  Type get value => _currentValue;

  /// Altera o valor.
  ///
  /// [newValue] representa o novo valor.
  ///
  set value(Type newValue) {
    _currentValue = newValue;
    _controller.add(_currentValue);
  }

  /// Retorna o stream associado ao valor.
  Stream<Type> get stream => _controller.stream;

  /// Retorna um [StreamBuilder] já configurado para o monitoramento do valor.
  StreamBuilder<Type> streamBuilder({ required AsyncWidgetBuilder<Type> builder }) {
    return StreamBuilder<Type>(
      stream: stream,
      initialData: value,
      builder: builder,
    );
  }

  /// Libera os recursos utilizados.
  void dispose() => _controller.close();
}