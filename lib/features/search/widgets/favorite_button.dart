import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozlyuk/features/favorites/bloc/favorite_word_cubit.dart';

import '../bloc/search_word/search_word_cubit.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      )),
      onPressed: () {
        context.read<SearchWordCubit>().deleteOrSaveWord();
        BlocProvider.of<FavoriteWordCubit>(context).getFavoriteWords();
      },
      child: context.watch<SearchWordCubit>().state.isInSaves
          ? const Icon(Icons.star)
          : const Icon(Icons.star_outline),
    );
  }
}
