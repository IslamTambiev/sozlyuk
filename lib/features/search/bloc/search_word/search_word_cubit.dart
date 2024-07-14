import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/word_model.dart';
import '../../../../services/db.dart';
import '../../../../services/saved_db.dart';

part 'search_word_state.dart';

class SearchWordCubit extends Cubit<SearchWordState> {
  SearchWordCubit() : super(const SearchWordState());

  void showTranslation() async {
    final String result;
    if (state.selectedId == null) {
      result = "Что-то пошло не так.";
    } else {
      result = (await DatabaseHelper.instance.getOneTranslation(
          state.isButtonClicked ? 'slovarrkb' : 'slovarkbr', state.selectedId!))!;
    }
    emit(SearchWordState(
      selectedId: state.selectedId,
      searchingWord: state.searchingWord,
      selectedWord: state.selectedWord,
      result: result,
      isVisible: state.isVisible,
      isButtonClicked: state.isButtonClicked,
      isInSaves: state.isInSaves,
      lang: state.lang,
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
      lang: state.lang,
    ));
  }

  void saveWord() async {
    try {
      await SavedDatabaseHelper.instance.add(
          WordTranslation(id: state.selectedId, slovo: state.selectedWord, lang: state.lang));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void checkWord() async {
    bool isWordInSaves =
    await SavedDatabaseHelper.instance.getOneTranslation(state.selectedId, state.lang);
    emit(SearchWordState(
      selectedId: state.selectedId,
      searchingWord: state.searchingWord,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: state.isVisible,
      isButtonClicked: state.isButtonClicked,
      isInSaves: isWordInSaves,
      lang: state.lang,
    ));
  }

  void deleteWord() async {
    await SavedDatabaseHelper.instance.remove(state.selectedId, state.lang);
    emit(SearchWordState(
      selectedId: state.selectedId,
      searchingWord: state.searchingWord,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: state.isVisible,
      isButtonClicked: state.isButtonClicked,
      isInSaves: false,
      lang: state.lang,
    ));
  }

  void searchWord(String word) {
    emit(SearchWordState(
      selectedId: state.selectedId,
      searchingWord: word,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: state.isVisible,
      isButtonClicked: state.isButtonClicked,
      isInSaves: state.isInSaves,
      lang: state.lang,
    ));
  }

  void setVisible() {
    emit(SearchWordState(
      selectedId: state.selectedId,
      searchingWord: state.searchingWord,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: !state.isVisible,
      isButtonClicked: state.isButtonClicked,
      isInSaves: state.isInSaves,
      lang: state.lang,
    ));
  }
}
