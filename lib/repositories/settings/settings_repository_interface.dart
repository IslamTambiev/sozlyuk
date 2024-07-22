abstract interface class SettingsRepositoryInterface {
  bool isDarkThemeSelected();

  Future<void> setDarkThemeSelected(bool selected);

  bool needToSaveHistory();

  Future<void> setNeedToSaveHistory(bool selected);
}
