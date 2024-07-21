import 'package:shared_preferences/shared_preferences.dart';
import 'package:sozlyuk/repositories/settings/settings.dart';

class SettingsRepository implements SettingsRepositoryInterface {
  final SharedPreferences preferences;

  SettingsRepository({required this.preferences});

  static const _isDarkThemeSelectedKey = 'dark_theme_selected';
  static const _needToSaveHistoryKey = 'need_to_save_history';

  @override
  bool isDarkThemeSelected() {
    final selected = preferences.getBool(_isDarkThemeSelectedKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDarkThemeSelectedKey, selected);
  }

  @override
  bool needToSaveHistory() {
    final selected = preferences.getBool(_needToSaveHistoryKey);
    return selected ?? true;
  }

  @override
  Future<void> setNeedToSaveHistory(bool selected) async {
    await preferences.setBool(_needToSaveHistoryKey, selected);
  }
}
