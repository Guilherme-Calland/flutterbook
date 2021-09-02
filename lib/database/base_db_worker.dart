import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database_brain.dart' as dbBrain;

class DatabaseWorker {
  String databaseType;
  Database? _db;

  DatabaseWorker({required this.databaseType});

  Future<Database?> get database async {
    if(_db == null){
      _db = await _initializeDatabase();
    }
    return _db;
  }

  Future<Database?> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    String notesDBPath = join(databasePath, '$databaseType.db');
    Database db =
    await openDatabase(
        notesDBPath,
        version: 1,
        onCreate: _onCreateDB
    );
    return db;
  }

  Future<void> _onCreateDB(Database db, int version) async {
    String? sql = retrieveSqlFromType();
    if(sql!=null){
      await db.execute(sql);
    }
  }

  String? retrieveSqlFromType(){
    String? sqlTemp;
    switch(this.databaseType){
      case 'notes':
        sqlTemp = dbBrain.notesSql;
        break;
      case 'tasks':
        sqlTemp = dbBrain.tasksSql;
        break;
    }
    return sqlTemp;
  }

  Future<int?> create(Map<String, dynamic> inData) async{
    Database? db = await database;
    int? result;
    if(db!=null){
      result = await db.insert('$databaseType', inData);
    }
    return result;
  }

  Future< List< Map>?> read() async{
    Database? db = await database;
    if(db!=null){
      String sql = 'SELECT * FROM $databaseType ORDER BY id';
      List< Map< String, dynamic>> data = await db.rawQuery(sql);
      return data;
    }
    return null;
  }

  Future<int?> update(Map< String, dynamic> data) async{
    Database? db = await database;
    int? result;
    if(db!=null){
      result = await db.update(
          '$databaseType',
          data,
          where: 'id = ?',
          whereArgs: [ data['id'] ]
      );
    }
    return result;
  }

  Future<int?> delete(int inID) async {
    Database? db = await database;
    int? outResult;
    if(db != null){
      outResult = await
      db.delete(
          '$databaseType',
          where: 'id=?',
          whereArgs: [inID]
      );
    }
    return outResult;
  }

  Future< Map< String, dynamic>?> get(int inID) async{
    Database? db = await database;
    if(db != null){
      List query = await db.query(
          '$databaseType', where: 'id = ?', whereArgs: [inID]
      );
      final result = query.first;
      return result;
    }
    return null;
  }
}