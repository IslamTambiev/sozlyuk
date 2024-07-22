import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_word/search_word_cubit.dart';

class LangButton extends StatelessWidget {
  const LangButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      )),
      onPressed: () => context.read<SearchWordCubit>().toggleButtonText(),
      child: Text(
        context.watch<SearchWordCubit>().state.isButtonClicked
            ? 'РУС -\nКАР-БАЛ'
            : 'КАР-БАЛ\n- РУС',
        style: const TextStyle(fontSize: 9.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}
