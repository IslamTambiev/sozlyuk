import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozlyuk/features/favorites/bloc/favorite_word_cubit.dart';
import 'package:sozlyuk/repositories/models/word_model.dart';

import '../../search/bloc/search_word/search_word_cubit.dart';

class FavoriteWordCard extends StatelessWidget {
  const FavoriteWordCard({
    super.key,
    required this.word,
  });
  //
  final WordTranslation word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 1),
        color: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.3),
            width: 1.0,
          ),
        ),
        elevation: 0.0,
        child: ListTile(
          trailing: IconButton(
            icon: Icon(
              Icons.close_rounded,
              color: theme.colorScheme.tertiary,
            ),
            onPressed: () {
              context
                  .read<FavoriteWordCubit>()
                  .deleteTranslation(word.id, word.lang);
              BlocProvider.of<SearchWordCubit>(context)
                  .updateFavoriteButton(word.id, word.lang == 1 ? true : false);
            },
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          title: Text(
            word.slovo,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:
                  context.watch<FavoriteWordCubit>().state.selectedId == word.id
                      ? theme.colorScheme.onPrimaryContainer.withOpacity(0.4)
                      : theme.colorScheme.onPrimaryContainer,
            ),
          ),
          onTap: () {
            context
                .read<FavoriteWordCubit>()
                .showTranslation(word.id, word.slovo, word.lang!);
          },
        ),
      ),
    );
  }
}
