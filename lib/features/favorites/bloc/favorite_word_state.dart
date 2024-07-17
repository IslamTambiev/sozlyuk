part of 'favorite_word_cubit.dart';

class FavoriteWordState extends Equatable {
  const FavoriteWordState({
    this.selectedId,
    this.selectedWord = "",
    this.result = "",
    this.isVisible = false,
    this.lang,
    this.favoriteWords = const [],
  });

  final int? selectedId;
  final String selectedWord;
  final String result;
  final bool isVisible;
  final int? lang;
  final List<WordTranslation> favoriteWords;

  @override
  List<Object?> get props => [
        selectedId,
        selectedWord,
        result,
        isVisible,
        lang,
        favoriteWords,
      ];
}
