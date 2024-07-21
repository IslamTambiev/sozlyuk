import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sozlyuk/bloc/theme/theme_cubit.dart';
import 'package:sozlyuk/features/favorites/bloc/favorite_word_cubit.dart';
import 'package:sozlyuk/features/history/bloc/history_words_cubit.dart';
import 'package:sozlyuk/features/search/bloc/search_word/search_word_cubit.dart';
import 'package:sozlyuk/repositories/settings/settings.dart';
import 'package:sozlyuk/router/router.dart';
import 'package:sozlyuk/ui/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //await DB.init();
  runApp(MyApp(preferences: prefs));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.preferences});

  final SharedPreferences preferences;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // Set the status bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black38, // Change the color here
    ));

    final settingsRepository =
        SettingsRepository(preferences: widget.preferences);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ThemeCubit(settingsRepository: settingsRepository)),
        BlocProvider(create: (context) => SearchWordCubit()),
        BlocProvider(create: (context) => FavoriteWordCubit()),
        BlocProvider(
            create: (context) =>
                HistoryWordsCubit(settingsRepository: settingsRepository)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            //home: const MyHomePage(),
            title: 'Сёзлюк',
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
