abstract class ViewBinding<MinutesView> {
  /// Referência para a view;
  MinutesView? view;
}

extension ViewBindingExtension<MinutesView> on ViewBinding<MinutesView> {
  /// Passa uma referência da view.
  void bindView(MinutesView view) => this.view = view;

  /// Remove a referência para a view.
  void unbindView() => view = null;
}
