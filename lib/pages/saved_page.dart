import 'package:flutter/material.dart';

import '../services/db.dart';
import '../services/saved_db.dart';
import '../models/word_model.dart';

class SavedTab extends StatefulWidget {
  const SavedTab({super.key});

  @override
  State<SavedTab> createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab>
    with AutomaticKeepAliveClientMixin<SavedTab> {
  int? selectedId;
  late String searchingWord;
  late String selectedWord;
  late String result;
  late bool isvisible;
  late bool isButtonClicked;

  @override
  void initState() {
    super.initState();
    searchingWord = '';
    selectedWord = '';
    result = '';
    isvisible = false;
    isButtonClicked = false;
  }

  void showTranslation() async {
    if (selectedId == null) {
      result = "Что-то пошло не так.";
    } else {
      String text = (await DatabaseHelper.instance.getOneTranslation(
          isButtonClicked ? 'slovarrkb' : 'slovarkbr', selectedId!))!;
      setState(() {
        result = text;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Colors.indigo.shade500,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Длительное нажатие удаляет слово из списка",
                          style: TextStyle(
                              fontSize: 18,),
                        ),
                      ]),
                ),
                FutureBuilder<List<WordTranslation>>(
                    future: SavedDatabaseHelper.instance.getTranslation(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<WordTranslation>> snapshot) {
                      if (isvisible) {
                        print('isvisible');
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text('Ищем...'));
                      }
                      return snapshot.data!.isEmpty
                          ? const Center(
                              child: Text(
                                'Нет слов.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ))
                          : ListView(
                              //shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: snapshot.data!.map((word) {
                                return Center(
                                  child: Card(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    color: Colors.blue.shade50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1.0,
                                      ),
                                    ),
                                    elevation: 2,
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 16),
                                      title: Text(
                                        word.slovo,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: selectedId == word.id
                                              ? Colors.black
                                              : Colors.grey[800],
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedWord = word.slovo;
                                          selectedId = word.id;
                                          showTranslation();
                                          isvisible = true;
                                        });
                                      },
                                      onLongPress: () {
                                        SavedDatabaseHelper.instance.remove(id: word.id, lang: word.lang);
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
