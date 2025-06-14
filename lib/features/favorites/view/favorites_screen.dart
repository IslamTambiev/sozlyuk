import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozlyuk/features/favorites/bloc/favorite_word_cubit.dart';
import 'package:sozlyuk/features/favorites/widgets/widgets.dart';

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
  void initState() {
    super.initState();
    context.read<FavoriteWordCubit>().getFavoriteWords();
  }

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
                      context
                              .watch<FavoriteWordCubit>()
                              .state
                              .favoriteWords
                              .isEmpty
                          ? Stack(children: [
                              const FavoritesNotFound(),
                              ListView(children: const [
                                SizedBox.shrink(),
                              ]),
                            ])
                          : CustomScrollView(
                              // shrinkWrap: true,
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      final word = state.favoriteWords[index];
                                      return FavoriteWordCard(word: word);
                                    },
                                    childCount: state.favoriteWords.length,
                                  ),
                                ),
                              ],
                            ),

                      context.watch<FavoriteWordCubit>().state.isVisible
                          ? PopScope(
                              canPop: false,
                              onPopInvokedWithResult:
                                  (didPop, Object? result) async {
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
                              child: Container(
                                color: theme.colorScheme.surface,
                                child: const Column(children: [
                                  Row(children: [
                                    Expanded(child: SelectedWordLine())
                                  ]),
                                  SizedBox(height: 16.0),
                                  Expanded(child: ResultField()),
                                ]),
                              ),
                            )
                          : const SizedBox.shrink(),
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
