import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozlyuk/features/history/bloc/history_words_cubit.dart';
import 'package:sozlyuk/features/history/history.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with AutomaticKeepAliveClientMixin<HistoryScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<HistoryWordsCubit>().getHistoryWords();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    return SafeArea(
      child: BlocBuilder<HistoryWordsCubit, HistoryWordsState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      const SizedBox.shrink(),
                      context
                              .watch<HistoryWordsCubit>()
                              .state
                              .historyWords
                              .isEmpty
                          ? Stack(children: [
                              const HistoryNotFound(),
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
                                      final word = state.historyWords[index];
                                      return HistoryWordCard(word: word);
                                    },
                                    childCount: state.historyWords.length,
                                  ),
                                ),
                              ],
                            ),
                      context
                              .read<HistoryWordsCubit>()
                              .state
                              .historyWords
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Positioned(
                              bottom: 16.0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    context
                                        .read<HistoryWordsCubit>()
                                        .clearHistory();
                                  },
                                  icon: const Icon(Icons.clear_all),
                                  label: const Text('Очистить историю'),
                                ),
                              ),
                            ),
                      context.watch<HistoryWordsCubit>().state.isVisible
                          ? PopScope(
                              canPop: false,
                              onPopInvokedWithResult:
                                  (didPop, Object? result) async {
                                context
                                    .read<HistoryWordsCubit>()
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
