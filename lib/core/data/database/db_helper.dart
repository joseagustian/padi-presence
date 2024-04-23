import 'package:sqflite/sqflite.dart';
import 'db_tables.dart';

class DatabaseHelper {
  static const String _databaseName = 'padi.db';
  static const _databaseVersion = 1;
  static Database? _database;

  final DatabaseTables tables = DatabaseTables();

  factory DatabaseHelper() {
    return DatabaseHelper._internal();
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String path = '$databasePath/$_databaseName';

    final database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );

    return database;
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${tables.padiUserAccountTable.name} (
        ${tables.padiUserAccountTable.schema}
      )
    ''');
  }

  Future<bool> isDbCreated() async {
    final Database db = await database;
    return await _tableExists(db, tables.padiUserAccountTable.name);
  }

  Future<bool> _tableExists(Database db, String tableName) async {
    final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return result.isNotEmpty;
  }

  Future<void> createTable(String tableName, String tableSchema) async {
    final Database db = await database;
    await db.execute('CREATE TABLE IF NOT EXISTS $tableName ($tableSchema)');
  }

  Future<void> dropTable(String tableName) async {
    final Database db = await database;
    await db.execute('DROP TABLE IF EXISTS $tableName');
  }
}
