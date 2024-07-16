import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozlyuk/features/favorites/bloc/favorite_word_cubit.dart';

class SelectedWordLine extends StatelessWidget {
  const SelectedWordLine({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          context.watch<FavoriteWordCubit>().state.selectedWord,
          style: TextStyle(
              color: theme.colorScheme.onPrimaryContainer,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ));
  }
}
