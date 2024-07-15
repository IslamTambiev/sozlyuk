import 'package:flutter/material.dart';

class WordNotFound extends StatelessWidget {
  const WordNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
        child: Container(
      height: 50,
      width: 250,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        'Нет такого слова.',
        style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
    ));
  }
}
