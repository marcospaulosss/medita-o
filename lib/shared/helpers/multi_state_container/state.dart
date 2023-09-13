/// Estado do container.
enum ContainerState {

  /// O conteúdo do container ainda está sendo carregado.
  loading,

  /// O conteúdo do container está pronto.
  normal,

  /// O conteúdo do container muda para sucesso.
  success,

  /// Não foi possível carregar o conteúdo do container.
  error,
}