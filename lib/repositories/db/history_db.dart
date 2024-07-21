import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sozlyuk/repositories/models/word_model.dart';

class HistoryDatabaseHelper {
  HistoryDatabaseHelper._privateConstructor();

  static final HistoryDatabaseHelper instance =
      HistoryDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, 'historyDB.db');
    //databaseFactory.deleteDatabase(dbPath);
    //File(dbPath).delete();

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
      // onUpgrade: (Database db, int oldV, int newV) async {
      //   if (oldV < newV) {
      //     await db.execute('ALTER TABLE history ADD COLUMN lang INTEGER');
      //   }
      // },
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history(
          id INTEGER PRIMARY KEY,
          slovo TEXT,
          lang INTEGER
      )
      ''');
  }

  Future<List<WordTranslation>> getTranslation() async {
    Database db = await instance.database;
    var words = await db.query('history');
    List<WordTranslation> wordsList = words.isNotEmpty
        ? words.map((c) => WordTranslation.fromMap(c)).toList()
        : [];
    return wordsList;
  }

  Future<bool> getOneTranslation(int? id, int? lang) async {
    Database db = await instance.database;
    var word = await db
        .query('history', where: 'id = ? AND lang = ?', whereArgs: [id, lang]);
    if (word.isEmpty) {
      return false;
    } else {
      return true;
    }
    // return word[0]["slovo"].toString();
  }

  Future<int> add(WordTranslation word) async {
    Database db = await instance.database;
    return await db.insert('history', word.toMap());
  }

  Future<int> remove(int? id, int? lang) async {
    Database db = await instance.database;
    return await db
        .delete('history', where: 'id = ? AND lang = ?', whereArgs: [id, lang]);
  }

  Future<int> clearHistory() async {
    Database db = await instance.database;
    return await db.delete('history');
  }
}
