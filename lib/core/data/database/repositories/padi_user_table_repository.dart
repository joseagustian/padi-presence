import 'package:padi/core/data/database/db_helper.dart';
import 'package:padi/core/data/database/models/padi_user_model.dart';
import 'package:sqflite/sqflite.dart';

class PadiUserAccountTableRepository {

  DatabaseHelper helper = DatabaseHelper();

  Future<void> insertPadiUserAccount(PadiUserAccountModel data) async {
    final database = await helper.database;
    await database.insert(
      helper.tables.padiUserAccountTable.name,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<PadiUserAccountModel?> getPadiUserAccount() async {
    final database = await helper.database;

    try {
      final List<Map<String, dynamic>> maps = await database.query(
        helper.tables.padiUserAccountTable.name,
      );
      return PadiUserAccountModel.fromMap(maps.first);
    } catch (e) {
      return null;
    }
  }

  Future<void> deletePadiUserAccount() async {
    final database = await helper.database;
    await database.delete(
      helper.tables.padiUserAccountTable.name,
    );
  }

  Future<void> updatePadiUserAccount(PadiUserAccountModel data) async {
    final database = await helper.database;
    await database.update(
      helper.tables.padiUserAccountTable.name,
      data.toMap(),
      where: 'user_id = ?',
      whereArgs: [data.userId],
    );
  }

}