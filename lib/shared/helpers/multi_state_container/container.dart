import 'package:flutter/material.dart';

import 'controller.dart';
import 'state.dart';

/// Widget que representa um container com multiplos estado.
class MultiStateContainer extends StatelessWidget {
  /// Controlador do container.
  final MultiStateContainerController controller;

  /// O que será exibido quando o conteúdo do container estiver sendo carregado.
  final WidgetBuilder loadingStateBuilder;

  /// O que será exibido quando o conteúdo do container estiver pronto.
  final WidgetBuilder normalStateBuilder;

  /// O que será exibido quando a tela deve apresentar sucesso.
  final WidgetBuilder? successStateBuilder;

  /// O que será exibido quando não for possível carregar o conteúdo do container.
  final WidgetBuilder errorStateBuilder;

  /// Cria o widget que representa um container com multiplos estado.
  ///
  /// [controller] representa o controlador do container;
  /// [loadingStateBuilder] representa o que será exibido quando o conteúdo do container estiver sendo carregado;
  /// [normalStateBuilder] representa o que será exibido quando o conteúdo do container estiver pronto;
  /// [successStateBuilder] representa o que será exibido quando quando a tela deve apresentar sucesso;
  /// [errorStateBuilder] representa o que será exibido quando não for possível carregar o conteúdo do container;
  ///
  const MultiStateContainer({
    Key? key,
    required this.controller,
    required this.normalStateBuilder,
    required this.loadingStateBuilder,
    this.successStateBuilder,
    required this.errorStateBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: StreamBuilder(
        stream: controller.state.stream,
        initialData: controller.state.value,
        builder: (context, stateSnapshot) => contentForCurrentState(context),
      ),
    );
  }

  /// Retorna o conteúdo que deve ser exibido, de acordo com o estado atual.
  ///
  /// [context] representa o contexto atual.
  ///
  Widget contentForCurrentState(BuildContext context) {
    switch (controller.state.value) {
      case ContainerState.loading:
        return loadingStateBuilder(context);
      case ContainerState.normal:
        return normalStateBuilder(context);
      case ContainerState.success:
        if (successStateBuilder != null) {
          return successStateBuilder!(context);
        }
        return errorStateBuilder(context);
      case ContainerState.error:
        return errorStateBuilder(context);
    }
  }
}
