import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE NOT NULL,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  Future<Map<String, dynamic>?> insertUser(Map<String, dynamic> userData) async {
    final db = await database;
    final userId = await db.insert('users', userData);
    return getUserById(userId);
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await instance.database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }
  
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await instance.database;
    final result = await db.query('users', where: 'email = ?', whereArgs: [email]);
    return result.isNotEmpty ? result.first : null;
  }
  
  Future<Map<String, dynamic>?> getUserByPhone(String phone) async {
    final db = await instance.database;
    final result = await db.query('users', where: 'phone = ?', whereArgs: [phone]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
