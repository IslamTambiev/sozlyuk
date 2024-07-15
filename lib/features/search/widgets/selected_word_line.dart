import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_word/search_word_cubit.dart';

class SelectedWordLine extends StatelessWidget {
  const SelectedWordLine({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: theme.colorScheme.primaryContainer,
      shadowColor: Colors.transparent,
      type: MaterialType.card,
      child: Container(
          height: 35,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              context.watch<SearchWordCubit>().state.selectedWord,
              style: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
