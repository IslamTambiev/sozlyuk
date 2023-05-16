import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'sqliteexample.dart';
import 'info_page.dart';
//import 'saved_page.dart';
import 'search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await DB.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the status bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black38, // Change the color here
    ));
    final ThemeData theme = ThemeData();
    return MaterialApp(
      home: const MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
            primary: Colors.indigo.shade500,
            secondary: Colors.indigoAccent.shade200),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
        children: const [
          SearchTab(),
          SqliteApp(),
          InfoTab(),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////

///////////////////////////////////////////////
// class DBHomePage extends StatefulWidget {
//   //DBHomePage({Key key, this.title}) : super(key: key);
//
//   @override
//   _DBHomePageState createState() => _DBHomePageState();
// }
//
// class _DBHomePageState extends State<DBHomePage> {
//   late String _task;
//   List<TodoItem> _tasks = [];
//   final TextStyle _style = const TextStyle(color: Colors.white, fontSize: 24);
//
//   List<Widget> get _items => _tasks.map((item) => format(item)).toList();
//
//   Widget format(TodoItem item) {
//     return Dismissible(
//       key: Key(item.id.toString()),
//       child: Padding(
//           padding: const EdgeInsets.fromLTRB(12, 6, 12, 4),
//           child: TextButton(
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(item.task.toString(), style: _style),
//                   Icon(
//                       item.complete == true
//                           ? Icons.radio_button_checked
//                           : Icons.radio_button_unchecked,
//                       color: Colors.white)
//                 ]),
//             onPressed: () => _toggle(item),
//           )),
//       onDismissed: (DismissDirection direction) => _delete(item),
//     );
//   }
//
//   void _toggle(TodoItem item) async {
//     print("_toggle");
//     if (item.complete == null) {
//       item.complete = false;
//     } else {
//       item.complete = true;
//     }
//
//     //item.complete = !item.complete;
//     dynamic result = await DB.update(TodoItem.table, item);
//     print(result);
//     refresh();
//   }
//
//   void _delete(TodoItem item) async {
//     DB.delete(TodoItem.table, item);
//     refresh();
//   }
//
//   void _save() async {
//     print("_save()");
//     print(_task);
//     Navigator.of(context).pop();
//     TodoItem item = TodoItem(task: _task, complete: false);
//
//     await DB.insert(TodoItem.table, item);
//     setState(() => _task = '');
//     print(_task);
//     refresh();
//   }
//
//   void _create(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Create New Task"),
//             actions: <Widget>[
//               TextButton(
//                   child: const Text('Cancel'),
//                   onPressed: () => Navigator.of(context).pop()),
//               TextButton(child: const Text('Save'), onPressed: () => _save())
//             ],
//             content: TextField(
//               autofocus: true,
//               decoration: const InputDecoration(
//                   labelText: 'Task Name', hintText: 'e.g. pick up bread'),
//               onChanged: (value) {
//                 _task = value;
//               },
//             ),
//           );
//         });
//   }
//
//   @override
//   void initState() {
//     print("initState()");
//     refresh();
//     super.initState();
//   }
//
//   void refresh() async {
//     print("refresh()");
//     List<Map<String, dynamic>> _results =
//         (await DB.query(TodoItem.table)) as List<Map<String, dynamic>>;
//     _tasks = _results.map((item) => TodoItem.fromMap(item)).toList();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(title: const Text("widget.title")),
//         body: Center(child: ListView(children: _items)),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             _create(context);
//           },
//           tooltip: 'New TO DO',
//           child: const Icon(Icons.library_add),
//         ));
//   }
// }
