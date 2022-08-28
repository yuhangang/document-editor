import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storage/db/base/base_db.dart';

class DatabaseHelper {
  final List<BaseObjectDBTable> tables;
  DatabaseHelper({required this.tables});
  // ignore: prefer_constructors_over_static_methods
  static late Database _database;
  static Database get database => _database;

  Future<String> _getDBPath() async => join(await getDatabasesPath(), "db");

  Future<void> resetDB() async => deleteDatabase(await _getDBPath());

  Future<void> init({bool isReset = false}) async {
    await Future.forEach<BaseObjectDBTable>(tables, (table) {
      log(table.createTable);
    });

    final String path = await _getDBPath();
    if (isReset) await deleteDatabase(path);
    _database = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
      final Batch batch = db.batch();

      await Future.forEach<BaseObjectDBTable>(tables, (table) {
        log(table.createTable);
        batch.execute(table.createTable);
      });

      await batch.commit(noResult: true);
    }, onUpgrade: (db, oldVer, newVer) {
      if (newVer == 2) {
        log('run');
        //db.execute("ALTER TABLE ${WorkOrderDB.instance.tableName} ADD COLUMN ${WorkOrderDB.columnEngineerName} TEXT;");
        //db.execute("ALTER TABLE ${WorkOrderDB.instance.tableName} ADD COLUMN ${WorkOrderDB.columnSOM} TEXT;");
      }
    });
  }
}
