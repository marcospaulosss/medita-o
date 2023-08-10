/// Parâmetros de um evento de analytics.
typedef AnalyticsParameters = Map<String, String>;

/// Evento de analytics.
class AnalyticsEvent {
  /// Nome do evento.
  final String name;

  /// Parâmetros do evento.
  final AnalyticsParameters? parameters;

  /// Cria um evento de analytics.
  ///
  /// -[name] representa o nome do evento;
  /// -[parameters] contém os parâmetros do evento.
  ///
  AnalyticsEvent({
    required this.name,
    this.parameters,
  });
}
