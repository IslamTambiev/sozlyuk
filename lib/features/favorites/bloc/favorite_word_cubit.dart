import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/db/db.dart';
import '../../../repositories/db/favorites_db.dart';

part 'favorite_word_state.dart';

class FavoriteWordCubit extends Cubit<FavoriteWordState> {
  FavoriteWordCubit() : super(const FavoriteWordState());

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
      result = (await DatabaseHelper.instance
          .getOneTranslation(checkTable(), id))!;
    }
    emit(FavoriteWordState(
      selectedId: id,
      selectedWord: word,
      result: result,
      isVisible: true,
      lang: lang,
    ));
  }

  void deleteTranslation(int? id, int? lang) async {
    if (id == null || lang == null) {
    } else {
      await SavedDatabaseHelper.instance.remove(id, lang);
      emit(FavoriteWordState(
        selectedId: state.selectedId,
        selectedWord: state.selectedWord,
        result: state.result,
        isVisible: state.isVisible,
        lang: state.lang,
      ));
    }
  }

  void setIsVisibleFalse() {
    emit(FavoriteWordState(
      selectedId: state.selectedId,
      selectedWord: state.selectedWord,
      result: state.result,
      isVisible: false,
      lang: state.lang,
    ));
  }
}
