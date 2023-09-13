import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/listenable_value.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/state.dart';

/// Controlador do container.
class MultiStateContainerController {
  /// Estado atual do container.
  final state = ListenableValue(ContainerState.loading);

  /// Libera todos os recursos utilizados.
  void dispose() {
    state.dispose();
  }

  /// Altera [state] para [ContainerState.loading].
  void showLoadingState() => state.value = ContainerState.loading;

  /// Altera [state] para [ContainerState.normal].
  void showNormalState() => state.value = ContainerState.normal;

  /// Altera [state] para [ContainerState.success].
  void showSuccessState() => state.value = ContainerState.success;

  /// Altera [state] para [ContainerState.error].
  void showErrorState() => state.value = ContainerState.error;
}
