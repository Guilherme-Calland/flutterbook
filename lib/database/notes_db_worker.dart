import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDBWorker {
  NotesDBWorker._();
  static final NotesDBWorker db = NotesDBWorker._();

  Database? _db;

  Future<Database?> get database async {
    if(_db == null){
      _db = await _initializeDatabase();
    }
    return _db;
  }

  Future<Database> _initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    String notesDBPath = join(databasePath, 'notes.db');
    Database db =
    await openDatabase(
        notesDBPath,
        version: 1,
        onCreate: _onCreateDB
    );
    return db;
  }

  Future<void> _onCreateDB(Database db, int version) async {
    String sql =
        'CREATE TABLE notes('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title TEXT, '
        'content TEXT, '
        'color TEXT'
        ')';
    await db.execute(sql);
  }
}