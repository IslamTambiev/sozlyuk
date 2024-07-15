import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_word/search_word_cubit.dart';

class WordSearchCard extends StatelessWidget {
  const WordSearchCard({
    super.key,
    required this.wordId,
    required this.word,
  });

  final int? wordId;
  final String word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 1),
        color: context.watch<SearchWordCubit>().state.selectedId == wordId
            ? theme.colorScheme.primaryContainer.withOpacity(0.2)
            : theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.3),
            width: 1.0,
          ),
        ),
        elevation: 0.0,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          title: Text(
            word,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: context.watch<SearchWordCubit>().state.selectedId == wordId
                  ? theme.colorScheme.onPrimaryContainer.withOpacity(0.4)
                  : theme.colorScheme.onPrimaryContainer,
            ),
          ),
          onTap: () {
            context.read<SearchWordCubit>().showTranslation(word, wordId);
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ),
    );
  }
}
