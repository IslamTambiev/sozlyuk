part of 'search_word_cubit.dart';

class SearchWordState extends Equatable {
  const SearchWordState({
    this.selectedId,
    this.searchingWord = "",
    this.selectedWord = "",
    this.result = "",
    this.isVisible = false,
    this.isButtonClicked = false,
    this.isInSaves = false,
  });
  final int? selectedId;
  final String searchingWord;
  final String selectedWord;
  final String result;
  final bool isVisible;
  final bool isButtonClicked;
  final bool isInSaves;

  @override
  List<Object?> get props => [
        selectedId,
        searchingWord,
        selectedWord,
        result,
        isVisible,
        isButtonClicked,
        isInSaves,
      ];
}

class WordSavedOrDeleted extends SearchWordState {
  const WordSavedOrDeleted({
    super.selectedId,
    super.searchingWord,
    super.selectedWord,
    super.result,
    super.isVisible,
    super.isButtonClicked,
    super.isInSaves,
  });
}
