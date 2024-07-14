import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    super.key,
    required this.cardColor,
    required this.wordColor,
    required this.word,
    required this.setVisible,
    required this.checkWord,
    required this.deleteFromFavorites,
  });

  final String word;
  final Color cardColor;
  final Color wordColor;
  final bool setVisible;
  final bool checkWord;
  final bool deleteFromFavorites;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 1),
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.3),
            width: 1.0,
          ),
        ),
        elevation: 0.0,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          title: Text(
            word,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: wordColor,
            ),
          ),
          // onTap: () {
          //   setState(() {
          //     selectedWord = word.slovo;
          //     selectedId = word.id;
          //     showTranslation();
          //     FocusManager.instance.primaryFocus?.unfocus();
          //     if (setVisible) {
          //       isVisible = true;
          //     } else {
          //       isVisible = false;
          //     }
          //   });
          //   if (checkWord) {
          //     checkWord();
          //   }
          // },
          // onLongPress: () {
          //   if (deleteFromFavorites) {
          //     deleteTranslation(word.id, word.lang);
          //   }
          // },
        ),
      ),
    );
  }
}
