import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: const Center(
        child: Text(
          'Saved Tab',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
