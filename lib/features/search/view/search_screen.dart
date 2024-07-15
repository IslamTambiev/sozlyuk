import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:never_behind_keyboard/never_behind_keyboard.dart';
import 'package:sozlyuk/features/search/bloc/search_word/search_word_cubit.dart';
import 'package:sozlyuk/features/search/widgets/widgets.dart';
import '../../../repositories/db/db.dart';
import '../../../repositories/models/word_model.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final theme = Theme.of(context);
    return SafeArea(
      child: BlocProvider(
        create: (context) => SearchWordCubit(),
        child: BlocBuilder<SearchWordCubit, SearchWordState>(
          builder: (context, state) {
            return Container(
              //color: Colors.indigo.shade500,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(child: SearchLine()),
                      SizedBox(width: 16.0),
                      SizedBox(width: 90, child: LangButton()),
                    ],
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        const Column(children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: SelectedWordLine()),
                              SizedBox(width: 16.0),
                              SizedBox(width: 90, child: FavoriteButton()),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Expanded(
                            child: ResultField(),
                          ),
                        ]),
                        FutureBuilder<List<WordTranslation>>(
                            future: DatabaseHelper.instance.getTranslation(
                                context
                                        .watch<SearchWordCubit>()
                                        .state
                                        .isButtonClicked
                                    ? 'slovarrkb'
                                    : 'slovarkbr',
                                context
                                    .watch<SearchWordCubit>()
                                    .state
                                    .searchingWord),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<WordTranslation>> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (context
                                          .watch<SearchWordCubit>()
                                          .state
                                          .searchingWord ==
                                      "" ||
                                  !context
                                      .watch<SearchWordCubit>()
                                      .state
                                      .isVisible) {
                                return const Center();
                              }
                              return snapshot.data!.isEmpty
                                  ? const WordNotFound()
                                  : Container(
                                      //height: MediaQuery.of(context).size.height - 550,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.surface,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: NeverBehindKeyboardArea(
                                        scrollView: ListView(
                                          //shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          children: snapshot.data!.map((word) {
                                            return WordSearchCard(
                                              wordId: word.id,
                                              word: word.slovo,
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
          },
        ),
      ),
    );
  }
}
