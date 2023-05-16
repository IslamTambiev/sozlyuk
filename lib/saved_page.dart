import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
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
