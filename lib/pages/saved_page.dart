import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
  int? lang;

  @override
  void initState() {
    super.initState();
    searchingWord = '';
    selectedWord = '';
    result = '';
    isvisible = false;
  }

  String checkTable() {
    if (lang == 0) {
      return 'slovarkbr';
    } else {
      return 'slovarrkb';
    }
  }

  void showTranslation() async {
    if (selectedId == null) {
      result = "Что-то пошло не так.";
    } else {
      String text = (await DatabaseHelper.instance
          .getOneTranslation(checkTable(), selectedId!))!;
      setState(() {
        result = text;
      });
    }
  }

  void deleteTranslation(int? id, int? lang) async {
    if (id == null || lang == null) {
    } else {
      await SavedDatabaseHelper.instance.remove(id, lang);
      setState(() {});
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
                            fontSize: 18,
                          ),
                        ),
                      ]),
                ),
                FutureBuilder<List<WordTranslation>>(
                    future: SavedDatabaseHelper.instance.getTranslation(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<WordTranslation>> snapshot) {
                      if (isvisible) {
                        return WillPopScope(
                          onWillPop: () async { setState(() {isvisible = false;}); return false; },
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      height: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Text(
                                        selectedWord,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: SingleChildScrollView(
                                  child: Html(
                                    data: result,
                                    style: {
                                      "body": Style(fontSize: const FontSize(19))
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text('Ищем...'));
                      }
                      return snapshot.data!.isEmpty
                          ? const Center(
                              child: Text(
                              'Нет сохранённых слов',
                              style: TextStyle(
                                fontSize: 20,
                              ),
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
                                          lang = word.lang;
                                          showTranslation();
                                          isvisible = true;
                                        });
                                      },
                                      onLongPress: () {
                                        deleteTranslation(word.id, word.lang);
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
