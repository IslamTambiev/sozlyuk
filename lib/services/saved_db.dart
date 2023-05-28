import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sozlyuk/models/word_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    //var dbDir = await getDatabasesPath();

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, 'saves.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
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

  // Future<String?> getOneTranslation(String table, int id) async {
  //   Database db = await instance.database;
  //   var word = await db.query(table, where: "_id = ${id}");
  //   return word[0]["perevod"].toString();
  // }

  Future<int> add(WordTranslation word) async {
    Database db = await instance.database;
    return await db.insert('saves', word.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('saves', where: 'id = ?', whereArgs: [id]);
  }
}
