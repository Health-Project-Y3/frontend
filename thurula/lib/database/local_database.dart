import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
   static final DatabaseHelper instance = DatabaseHelper._init();
   static Database? _database;

   DatabaseHelper._init();

   Future<Database> get database async {
      if (_database != null) return _database!;

      _database = await _initDB('thuruladb_local.db');
      return _database!;
   }

   Future<Database> _initDB(String dbName) async {
      final path = join(await getDatabasesPath(), dbName);
      return openDatabase(
         path,
         onCreate: (db, version) {
            return db.execute(
               'CREATE TABLE users(id TEXT PRIMARY KEY, token TEXT, username TEXT)',
            );
         },
         version: 1,
      );
   }
}
