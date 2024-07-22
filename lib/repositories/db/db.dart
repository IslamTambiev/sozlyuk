import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sozlyuk/repositories/models/word_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    // Construct the path to the app's writable database file:
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "app.db");

    // Delete any existing database:
    await deleteDatabase(dbPath);

    // Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load("assets/slovarbr.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);

    return await openDatabase(
      dbPath,
      version: 1,
    );
  }

  Future<List<WordTranslation>> getTranslation(
      String table, String word) async {
    if (word.trim() == "") {
      return [];
    }
    Database db = await instance.database;
    var words = await db.query(table,
        columns: ["id", "slovo"], where: "slovo LIKE '${word.trim()}%'");
    List<WordTranslation> wordsList = words.isNotEmpty
        ? words.map((c) => WordTranslation.fromMap(c)).toList()
        : [];
    return wordsList;
  }

  Future<String?> getOneTranslation(String table, int id) async {
    Database db = await instance.database;
    var word = await db.query(table, where: "id = $id");
    return word[0]["perevod"].toString();
  }
}
