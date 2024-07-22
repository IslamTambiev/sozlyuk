import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:sozlyuk/features/favorites/bloc/favorite_word_cubit.dart';

class ResultField extends StatelessWidget {
  const ResultField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        child: HtmlWidget(
          context.watch<FavoriteWordCubit>().state.result,
          textStyle: TextStyle(
              fontSize: 19, color: theme.colorScheme.onSecondaryContainer),
        ),
      ),
    );
  }
}
