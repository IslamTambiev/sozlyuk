import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sozlyuk/router/router.dart';
import 'package:sozlyuk/ui/theme/theme.dart';

import 'pages/search_page.dart';
import 'pages/info_page.dart';
import 'pages/saved_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await DB.init();
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const DynamicThemeBuilder(
//       title: 'ReVanced Manager',
//       home: NavigationView(),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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

    return MaterialApp.router(
      //home: const MyHomePage(),
      title: 'Сёзлюк title',
      theme: lightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Container(
            //padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3F51B5),
                  Color(0xFF0D47A1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.1),
              ),
              indicatorPadding: EdgeInsets.zero,
              tabs: const [
                Tab(
                  text: 'Поиск',
                  icon: Icon(Icons.search),
                ),
                Tab(
                  text: 'Сохраненное',
                  icon: Icon(Icons.bookmark),
                ),
                Tab(
                  text: 'Инфо',
                  icon: Icon(Icons.info),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SearchTab(
            needUpdate: () {
              setState(() {});
            },
          ),
          SavedTab(),
          const InfoTab(),
        ],
      ),
    );
  }
}
