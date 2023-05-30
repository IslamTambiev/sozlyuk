import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sozlyuk/models/word_model.dart';

class SavedDatabaseHelper {
  SavedDatabaseHelper._privateConstructor();
  static final SavedDatabaseHelper instance = SavedDatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, 'saveDB.db');
    //databaseFactory.deleteDatabase(dbPath);
    //File(dbPath).delete();

    return await openDatabase(
      dbPath,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: (Database db, int oldV, int newV) async {
        if (oldV < newV) {
          await db.execute('ALTER TABLE saves ADD COLUMN lang INTEGER');
        }
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE saves(
          id INTEGER PRIMARY KEY,
          slovo TEXT
      )
      ''');
  }

  Future<List<WordTranslation>> getTranslation() async {
    Database db = await instance.database;
    var words = await db.query('saves');
    List<WordTranslation> wordsList = words.isNotEmpty
        ? words.map((c) => WordTranslation.fromMap(c)).toList()
        : [];
    return wordsList;
  }

  Future<bool> getOneTranslation(int? id, int? lang) async {
    Database db = await instance.database;
    var word = await db.query('saves', where: 'id = ? AND lang = ?', whereArgs: [id, lang]);
    if (word.isEmpty) {
      return false;
    } else {
      return true;
    }
    // return word[0]["slovo"].toString();
  }

  Future<int> add(WordTranslation word) async {
    Database db = await instance.database;
    return await db.insert('saves', word.toMap());
  }

  Future<int> remove(int? id, int? lang) async {
    Database db = await instance.database;
    return await db.delete('saves', where: 'id = ? AND lang = ?', whereArgs: [id, lang]);
  }
}
