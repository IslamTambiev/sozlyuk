import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../repositories/db/db.dart';
import '../../../repositories/db/favorites_db.dart';
import '../../../repositories/models/word_model.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with AutomaticKeepAliveClientMixin<FavoritesScreen> {
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

    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        // color: Colors.indigo.shade500,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: <Widget>[
                  const SizedBox.shrink(),
                  // SizedBox.expand(
                  //   child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "Длительное нажатие удаляет слово из списка",
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             color: theme.colorScheme.onSurface.withOpacity(0.5),
                  //             fontSize: 16,
                  //           ),
                  //         ),
                  //       ]),
                  // ),
                  RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: FutureBuilder<List<WordTranslation>>(
                        future: SavedDatabaseHelper.instance.getTranslation(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<WordTranslation>> snapshot) {
                          if (isvisible) {
                            return PopScope(
                              canPop: false,
                              onPopInvoked: (didPop) async {
                                setState(() {
                                  isvisible = false;
                                });
                                bool canPop = Navigator.canPop(context);
                                if (canPop) {
                                  Navigator.pop(context);
                                } else {
                                  return;
                                }
                              },
                              child: Column(children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: theme
                                                .colorScheme.primaryContainer,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: Text(
                                            selectedWord,
                                            style: TextStyle(
                                                color: theme.colorScheme
                                                    .onPrimaryContainer,
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
                                      color:
                                          theme.colorScheme.secondaryContainer,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: SingleChildScrollView(
                                      child: HtmlWidget(
                                        result,
                                        textStyle: TextStyle(
                                            fontSize: 19,
                                            color: theme.colorScheme
                                                .onSecondaryContainer),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            );
                          }

                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return snapshot.data!.isEmpty
                              ? Stack(children: [
                                  const Center(
                                      child: Text(
                                    'Нет сохранённых слов',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )),
                                  ListView(
                                      children: const [
                                        SizedBox.shrink(),
                                      ]),
                                ])
                              : ListView(
                                  //shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  children: snapshot.data!.map((word) {
                                    return Center(
                                      child: Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 1),
                                        color:
                                            theme.colorScheme.primaryContainer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                            color: theme.colorScheme.outline
                                                .withOpacity(0.3),
                                            width: 1.0,
                                          ),
                                        ),
                                        elevation: 0.0,
                                        child: ListTile(
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.delete_outline,
                                              color: theme.colorScheme.tertiary,
                                            ),
                                            onPressed: () {
                                              deleteTranslation(
                                                  word.id, word.lang);
                                            },
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 16),
                                          title: Text(
                                            word.slovo,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: selectedId == word.id
                                                  ? theme.colorScheme
                                                      .onPrimaryContainer
                                                      .withOpacity(0.4)
                                                  : theme.colorScheme
                                                      .onPrimaryContainer,
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
                                          // onLongPress: () {
                                          //   deleteTranslation(
                                          //       word.id, word.lang);
                                          // },
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
