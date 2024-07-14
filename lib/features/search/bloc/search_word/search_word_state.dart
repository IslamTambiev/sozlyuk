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
    this.lang = 0,
  });
  final int? selectedId;
  final String searchingWord;
  final String selectedWord;
  final String result;
  final bool isVisible;
  final bool isButtonClicked;
  final bool isInSaves;
  final int lang;

  @override
  List<Object?> get props => [
        selectedId,
        searchingWord,
        selectedWord,
        result,
        isVisible,
        isButtonClicked,
        isInSaves,
        lang,
      ];
}
