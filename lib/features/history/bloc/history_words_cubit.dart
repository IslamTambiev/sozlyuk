import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozlyuk/repositories/db/db.dart';
import 'package:sozlyuk/repositories/db/history_db.dart';
import 'package:sozlyuk/repositories/models/word_model.dart';
import 'package:sozlyuk/repositories/settings/settings.dart';

part 'history_words_state.dart';

class HistoryWordsCubit extends Cubit<HistoryWordsState> {
  HistoryWordsCubit({
    required SettingsRepositoryInterface settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const HistoryWordsState()) {
    _checkHistorySettings();
  }

  final SettingsRepositoryInterface _settingsRepository;

  String checkTable() {
    if (state.lang == 0) {
      return 'slovarkbr';
    } else {
      return 'slovarrkb';
    }
  }

  void showTranslation(int? id, String word, int lang) async {
    final String result;
    if (id == null) {
      result = "Что-то пошло не так.";
    } else {
      result =
          (await DatabaseHelper.instance.getOneTranslation(checkTable(), id))!;
    }
    emit(HistoryWordsState(
      selectedId: id,
      selectedWord: word,
      result: result,
      isVisible: true,
      lang: lang,
      historyWords: state.historyWords,
      needToSaveHistory: state.needToSaveHistory,
    ));
  }

  void deleteTranslation(int? id, int? lang) async {
    if (id == null || lang == null) {
    } else {
      await HistoryDatabaseHelper.instance.remove(id, lang);
      final List<WordTranslation> words =
          await HistoryDatabaseHelper.instance.getTranslation();
      emit(HistoryWordsState(
        selectedId: state.selectedId,
        selectedWord: state.selectedWord,
        result: state.result,
        isVisible: state.isVisible,
        lang: state.lang,
        historyWords: words,
        needToSaveHistory: state.needToSaveHistory,
      ));
    }
  }

  void clearHistory() async {
    await HistoryDatabaseHelper.instance.clearHistory();
    emit(HistoryWordsState(
      selectedId: state.selectedId,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: state.isVisible,
      lang: state.lang,
      historyWords: const [],
      needToSaveHistory: state.needToSaveHistory,
    ));
  }

  void setIsVisibleFalse() {
    emit(HistoryWordsState(
      selectedId: state.selectedId,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: false,
      lang: state.lang,
      historyWords: state.historyWords,
      needToSaveHistory: state.needToSaveHistory,
    ));
  }

  void getHistoryWords() async {
    final List<WordTranslation> words =
        await HistoryDatabaseHelper.instance.getTranslation();
    emit(HistoryWordsState(
      selectedId: state.selectedId,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: state.isVisible,
      lang: state.lang,
      historyWords: words,
      needToSaveHistory: state.needToSaveHistory,
    ));
  }

  Future<void> saveWordToHistory(int id, String word, int lang) async {
    if (state.needToSaveHistory) {
      await HistoryDatabaseHelper.instance
          .add(WordTranslation(id: id, slovo: word, lang: lang));
      getHistoryWords();
    }
  }

  Future<void> setNeedToSaveHistory(bool selected) async {
    emit(HistoryWordsState(
      selectedId: state.selectedId,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: state.isVisible,
      lang: state.lang,
      historyWords: state.historyWords,
      needToSaveHistory: selected,
    ));
    await _settingsRepository.setNeedToSaveHistory(selected);
  }

  void _checkHistorySettings() {
    final selected = _settingsRepository.needToSaveHistory();
    emit(HistoryWordsState(
      selectedId: state.selectedId,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: state.isVisible,
      lang: state.lang,
      historyWords: state.historyWords,
      needToSaveHistory: selected,
    ));
  }
}
