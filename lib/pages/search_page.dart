import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:never_behind_keyboard/never_behind_keyboard.dart';
import '../services/db.dart';
import '../models/model.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab>
    with AutomaticKeepAliveClientMixin<SearchTab> {
  int? selectedId;
  String searchingWord = '';
  String selectedWord = '';
  String result = '';
  String translation = 'qwert';
  bool isvisible = false;
  bool isButtonClicked = false;

  void toggleButtonText() {
    setState(() {
      isButtonClicked = !isButtonClicked;
    });
  }

  void showTranslation() async {
    if (selectedId == null) {
      result = "Что-то пошло не так.";
    }
    result = (await DatabaseHelper.instance.getOneTranslation(
        isButtonClicked ? 'slovarrkb' : 'slovarkbr', selectedId!))!;
  }

  void searchWord(String word) {
    // Implement your logic to search for the word and fetch the translation
    // Update the 'translation' variable with the fetched translation
    //print(word);
    setState(() {
      searchingWord = word;
      // Update the 'translation' variable here
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
                            // Handle button press
                          },
                          child: const Icon(Icons.star),
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
                      //Text(
                      //   result,
                      //   style: const TextStyle(fontSize: 20.0),
                      // ),
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
                          ? const Center(child: Text('Нет такого слова.'))
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
