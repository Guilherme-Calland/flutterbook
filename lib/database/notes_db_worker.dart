import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDBWorker {
  factory NotesDBWorker(){
    return _notesDBWorker;
  }

  NotesDBWorker._internal();
  static final NotesDBWorker _notesDBWorker = NotesDBWorker._internal();

  Database? _db;

  Future<Database?> get database async {
    if(_db == null){
      _db = await _initializeDatabase();
    }
    return _db;
  }

  Future<Database?> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
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

  Future<int?> create(Map<String, dynamic> inData) async{
    Database? db = await database;
    int? result;
    if(db!=null){
      result = await db.insert('notes', inData);
    }
    return result;
  }
}