import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bookify.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        remember_me INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE fav_events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        event_id TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('DROP TABLE IF EXISTS fav_events');
      await db.execute('''
        CREATE TABLE fav_events (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          event_id TEXT NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
        )
      ''');
    }
  }


  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }
  
  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  Future<List<Map<String, dynamic>>> getRememberedUsers() async {
    final db = await instance.database;
    return await db.query(
      'users',
      where: 'remember_me = ?',
      whereArgs: [1],
    );
  }


  Future<int> insertFavorite(int userId, String eventId) async {
    final db = await instance.database;
    return await db.insert('fav_events', {'user_id': userId, 'event_id': eventId});
  }

  Future<int> removeFavorite(int userId, String eventId) async {
    final db = await instance.database;
    return await db.delete(
      'fav_events',
      where: 'user_id = ? AND event_id = ?',
      whereArgs: [userId, eventId],
    );
  }

  Future<bool> isFavorite(int userId, String eventId) async {
    final db = await instance.database;
    final maps = await db.query(
      'fav_events',
      where: 'user_id = ? AND event_id = ?',
      whereArgs: [userId, eventId],
    );
    return maps.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getUserFavorites(int userId) async {
    final db = await instance.database;
    return await db.query(
      'fav_events',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }
}
