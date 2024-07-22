import 'package:flutter/material.dart';

class HistoryNotFound extends StatelessWidget {
  const HistoryNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'История пуста',
      style: TextStyle(fontSize: 20),
    ));
  }
}
