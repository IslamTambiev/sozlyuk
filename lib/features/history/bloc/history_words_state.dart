part of 'history_words_cubit.dart';

class HistoryWordsState extends Equatable {
  const HistoryWordsState({
    this.selectedId,
    this.selectedWord = "",
    this.result = "",
    this.isVisible = false,
    this.lang,
    this.historyWords = const [],
    this.needToSaveHistory = true,
  });

  final int? selectedId;
  final String selectedWord;
  final String result;
  final bool isVisible;
  final int? lang;
  final List<WordTranslation> historyWords;
  final bool needToSaveHistory;

  @override
  List<Object?> get props => [
        selectedId,
        selectedWord,
        result,
        isVisible,
        lang,
        historyWords,
        needToSaveHistory
      ];
}
