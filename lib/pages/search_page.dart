import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:never_behind_keyboard/never_behind_keyboard.dart';
import '../services/db.dart';
import '../services/saved_db.dart';
import '../models/word_model.dart';

class SearchTab extends StatefulWidget {
  final VoidCallback? needUpdate;
  const SearchTab({super.key, required this.needUpdate});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab>
    with AutomaticKeepAliveClientMixin<SearchTab> {
  int? selectedId;
  late String searchingWord;
  late String selectedWord;
  late String result;
  late bool isvisible;
  late bool isButtonClicked;
  late int lang;

  @override
  void initState() {
    super.initState();
    searchingWord = '';
    selectedWord = '';
    result = '';
    isvisible = false;
    isButtonClicked = false;
    lang = 0;
  }

  void toggleButtonText() {
    setState(() {
      isButtonClicked = !isButtonClicked;
    });
  }

  void showTranslation() async {
    if (selectedId == null) {
      result = "Что-то пошло не так.";
    }
    String text = (await DatabaseHelper.instance.getOneTranslation(
        isButtonClicked ? 'slovarrkb' : 'slovarkbr', selectedId!))!;
    setState((){result = text;});
  }

  void saveWord() async {
    try {
      await SavedDatabaseHelper.instance.add(
          WordTranslation(id: selectedId, slovo: selectedWord, lang: lang));
    }
    catch (e){}
  }

  void searchWord(String word) {
    setState(() {
      searchingWord = word;
    });
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
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'Введите слово',
                    ),
                    style: const TextStyle(fontSize: 20),
                    onChanged: (value) {
                      isvisible = true;
                      searchWord(value);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                width: 90,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent.shade200,
                  ),
                  onPressed: () {
                    toggleButtonText();
                  },
                  child: Text(
                    isButtonClicked ? 'РУС - \nКАР-БАЛ' : 'КАР-БАЛ - \nРУС',
                    style: const TextStyle(fontSize: 10.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Column(children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                selectedWord,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      const SizedBox(width: 16.0),
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent.shade200,
                          ),
                          onPressed: () {
                            if(selectedWord != ''){
                              saveWord();
                              widget.needUpdate!();
                            }
                            if (isButtonClicked){
                              lang = 1;
                            }
                            else{
                              lang = 0;
                            }
                          },
                          child: const Icon(Icons.star_outline),
                        ),
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
                          style: {"body": Style(fontSize: const FontSize(19))},
                        ),
                      ),
                    ),
                  ),
                ]),
                FutureBuilder<List<WordTranslation>>(
                    future: DatabaseHelper.instance.getTranslation(
                        isButtonClicked ? 'slovarrkb' : 'slovarkbr',
                        searchingWord),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<WordTranslation>> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Ищем...'));
                      }
                      if (searchingWord == "" || !isvisible) {
                        return const Center();
                      }
                      return snapshot.data!.isEmpty
                          ? Center(
                              child: Container(
                              height: 30,
                              width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Text(
                                'Нет такого слова.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                          : Container(
                              //height: MediaQuery.of(context).size.height - 550,
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade500,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: NeverBehindKeyboardArea(
                                scrollView: ListView(
                                  //shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  children: snapshot.data!.map((word) {
                                    return Center(
                                      child: Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 1),
                                        color: selectedId == word.id
                                            ? Colors.blueGrey[300]
                                            : Colors.blue.shade50,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              isvisible = false;
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
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
