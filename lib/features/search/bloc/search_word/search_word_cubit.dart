import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repositories/db/db.dart';
import '../../../../repositories/db/favorites_db.dart';
import '../../../../repositories/models/word_model.dart';

part 'search_word_state.dart';

class SearchWordCubit extends Cubit<SearchWordState> {
  SearchWordCubit() : super(const SearchWordState());

  void showTranslation(String word, int? id) async {
    final String result;
    if (id == null) {
      result = "Что-то пошло не так.";
    } else {
      result = (await DatabaseHelper.instance.getOneTranslation(
          state.isButtonClicked ? 'slovarrkb' : 'slovarkbr', id))!;
    }
    bool isWordInSaves = await SavedDatabaseHelper.instance
        .getOneTranslation(id, state.isButtonClicked ? 1 : 0);
    emit(SearchWordState(
      selectedId: id,
      searchingWord: state.searchingWord,
      selectedWord: word,
      result: result,
      isVisible: false,
      isButtonClicked: state.isButtonClicked,
      isInSaves: isWordInSaves,
    ));
  }

  void toggleButtonText() {
    emit(SearchWordState(
      selectedId: state.selectedId,
      searchingWord: state.searchingWord,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: state.isVisible,
      isButtonClicked: !state.isButtonClicked,
      isInSaves: state.isInSaves,
    ));
  }

  Future<void> deleteOrSaveWord() async {
    if (state.selectedWord != '' && !state.isInSaves) {
      await SavedDatabaseHelper.instance.add(WordTranslation(
          id: state.selectedId,
          slovo: state.selectedWord,
          lang: state.isButtonClicked ? 1 : 0));
      emit(WordSavedOrDeleted(
        selectedId: state.selectedId,
        searchingWord: state.searchingWord,
        selectedWord: state.selectedWord,
        result: state.result,
        isVisible: state.isVisible,
        isButtonClicked: state.isButtonClicked,
        isInSaves: true,
      ));
    } else if (state.selectedWord != '' && state.isInSaves) {
      await SavedDatabaseHelper.instance
          .remove(state.selectedId, state.isButtonClicked ? 1 : 0);
      emit(WordSavedOrDeleted(
        selectedId: state.selectedId,
        searchingWord: state.searchingWord,
        selectedWord: state.selectedWord,
        result: state.result,
        isVisible: state.isVisible,
        isButtonClicked: state.isButtonClicked,
        isInSaves: false,
      ));
    }
  }

  void searchWord(String word) {
    emit(SearchWordState(
      selectedId: state.selectedId,
      searchingWord: word,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: true,
      isButtonClicked: state.isButtonClicked,
      isInSaves: state.isInSaves,
    ));
  }

  void updateFavoriteButton(int? id, bool isButtonClicked) {
    if (!state.isVisible && id != null && state.selectedId == id) {
      emit(SearchWordState(
        selectedId: state.selectedId,
        searchingWord: state.searchingWord,
        selectedWord: state.selectedWord,
        result: state.result,
        isVisible: state.isVisible,
        isButtonClicked: state.isButtonClicked,
        isInSaves: false,
      ));
    }
  }
}
