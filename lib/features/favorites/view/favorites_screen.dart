import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:sozlyuk/features/favorites/bloc/favorite_word_cubit.dart';
import 'package:sozlyuk/features/search/bloc/search_word/search_word_cubit.dart';

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
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    return SafeArea(
      child: BlocBuilder<FavoriteWordCubit, FavoriteWordState>(
        builder: (context, state) {
          return Container(
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
                            future:
                                SavedDatabaseHelper.instance.getTranslation(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<WordTranslation>> snapshot) {
                              if (context
                                  .watch<FavoriteWordCubit>()
                                  .state
                                  .isVisible) {
                                return PopScope(
                                  canPop: false,
                                  onPopInvoked: (didPop) async {
                                    context
                                        .read<FavoriteWordCubit>()
                                        .setIsVisibleFalse();
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
                                                color: theme.colorScheme
                                                    .primaryContainer,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Text(
                                                context
                                                    .watch<FavoriteWordCubit>()
                                                    .state
                                                    .selectedWord,
                                                style: TextStyle(
                                                    color: theme.colorScheme
                                                        .onPrimaryContainer,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                          color: theme
                                              .colorScheme.secondaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: SingleChildScrollView(
                                          child: HtmlWidget(
                                            context
                                                .watch<FavoriteWordCubit>()
                                                .state
                                                .result,
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
                                      ListView(children: const [
                                        SizedBox.shrink(),
                                      ]),
                                    ])
                                  : ListView(
                                      // shrinkWrap: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      children: snapshot.data!.map((word) {
                                        return Center(
                                          child: Card(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 1),
                                            color: theme
                                                .colorScheme.primaryContainer,
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
                                                  color: theme
                                                      .colorScheme.tertiary,
                                                ),
                                                onPressed: () {
                                                  context
                                                      .read<FavoriteWordCubit>()
                                                      .deleteTranslation(
                                                          word.id, word.lang);
                                                  setState(() {});
                                                  BlocProvider.of<
                                                              SearchWordCubit>(
                                                          context)
                                                      .updateFavoriteButton(
                                                          word.id,
                                                          word.lang == 1
                                                              ? true
                                                              : false);
                                                },
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 16),
                                              title: Text(
                                                word.slovo,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: context
                                                              .watch<
                                                                  FavoriteWordCubit>()
                                                              .state
                                                              .selectedId ==
                                                          word.id
                                                      ? theme.colorScheme
                                                          .onPrimaryContainer
                                                          .withOpacity(0.4)
                                                      : theme.colorScheme
                                                          .onPrimaryContainer,
                                                ),
                                              ),
                                              onTap: () {
                                                context
                                                    .read<FavoriteWordCubit>()
                                                    .showTranslation(word.id,
                                                        word.slovo, word.lang!);
                                              },
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
          );
        },
      ),
    );
  }
}
