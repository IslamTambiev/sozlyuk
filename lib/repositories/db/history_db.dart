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
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE history ADD COLUMN created_at TEXT");
          await db.execute("UPDATE history SET created_at = datetime('now')");
        }
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history(
          id INTEGER PRIMARY KEY,
          slovo TEXT,
          lang INTEGER,
          created_at TEXT
      )
      ''');
  }

  Future<List<WordTranslation>> getTranslation() async {
    Database db = await instance.database;
    var words = await db.query(
      'history',
      orderBy: 'created_at DESC',
    );
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

    // Проверяем, есть ли такая запись
    final existing = await getOneTranslation(word.id, word.lang);
    final now = DateTime.now().toIso8601String();

    if (existing) {
      // Обновляем только дату
      return await db.update(
        'history',
        {'created_at': now},
        where: 'id = ? AND lang = ?',
        whereArgs: [word.id, word.lang],
      );
    } else {
      // Добавляем новую запись с текущей датой
      Map<String, dynamic> map = word.toMap();
      map['created_at'] = now;
      return await db.insert('history', map);
    }
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
