import 'package:flutter/material.dart';

class FavoritesNotFound extends StatelessWidget {
  const FavoritesNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Нет сохранённых слов',
      style: TextStyle(fontSize: 20),
    ));
  }
}
