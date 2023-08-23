enum PageState {
  initial,
  loading,
  success,
  failure;

  bool get isLoadingOrSuccess => [PageState.loading, PageState.success].contains(this);
}
