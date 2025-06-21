import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_word/search_word_cubit.dart';

class SearchLine extends StatelessWidget {
  const SearchLine({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      borderRadius: BorderRadius.circular(10),
      shadowColor: Colors.transparent,
      color: theme.colorScheme.secondaryContainer,
      type: MaterialType.card,
      // alignment: Alignment.centerLeft,
      child: Container(
        height: 35,
        alignment: Alignment.centerLeft,
        //padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: TextField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            isDense: true,
            border: InputBorder.none,
            hintText: 'Введите слово',
          ),
          style: TextStyle(
              fontSize: 20, color: theme.colorScheme.onSecondaryContainer),
          onChanged: (value) =>
              context.read<SearchWordCubit>().searchWord(value),
          onTap: () => context
              .read<SearchWordCubit>()
              .searchWord(context.read<SearchWordCubit>().state.searchingWord),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[а-яА-ЯёЁ\s\-]')),
          ],
        ),
      ),
    );
  }
}
