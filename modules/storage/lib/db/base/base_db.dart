import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storage/db/base/database_helper.dart';
import 'package:storage/db/base/db_schema_util.dart';
import 'package:storage/db/helper/db_value_filter.dart';

export 'package:sqflite/sqflite.dart' show ConflictAlgorithm;

abstract class BaseObjectDBTable<T> {
  BaseObjectDBTable({required this.tableName});
  Database get db => DatabaseHelper.database;
  String get id => "id";
  bool get isPKAutoIncrement => false;
  List<SqfField> get fields;

  T toObject(Map<String, Object?> json);

  Map<String, dynamic> toJson(T item);

  /// conflict algorithm when insert DB
  ConflictAlgorithm get conflictAlgorithmInsert => ConflictAlgorithm.replace;

  /// put building script of columns of table, except "id" and "sync_status" which is handled by base class
  String get createQuery {
    final uniqueFieldsNames =
        fields.where((element) => element.isUnique).map((e) => e.name).toList();
    return [
      ...fields.map((field) => field.toString()),
      ...fields.whereType<SqfFieldWithRelation>().map((e) => e.relationText),
      if (uniqueFieldsNames.isNotEmpty)
        "UNIQUE(${uniqueFieldsNames.join(", ")})"
    ].join(', ');
  }

  /// unique indentifier of table
  final String tableName;

  ///put primary list of primary key of children
  @mustCallSuper
  List<String> get primaryKeys => [id];

  /// put list of foreign Keys and Contraints script builted from helper function
  List<String>? get foreignKeyAndConstaints => null;

  /// main function to building create table script, pls avoid overriding this method in child class,
  String get createTable => """
      ${DBHelper.buildCreateTableString(
        tableName,
      )}($createQuery)
          """;

  Future<void> insert(T item) async {
    //
    // await db.insert(tableName, item.toJson(),
    //     conflictAlgorithm: conflictAlgorithmInsert);

    DatabaseHelper.database.transaction((txn) async {
      final batch = txn.batch();

      batch.insert(tableName, toJson(item),
          conflictAlgorithm: conflictAlgorithmInsert);

      //await batch.commit();
      log((await batch.commit()).toString());
    });

    //log("item inserted to $tableName : ${item.id}");
  }

  // Future<void> update(T item) async {
  //   await db.update(tableName, toJson(item),
  //       where: '$id = ?',
  //       whereArgs: [item.id],
  //       conflictAlgorithm: ConflictAlgorithm.replace);
//
  //   //log("item inserted to $tableName : ${item.id}");
  // }

  /// use this function when you need to insert large amount of data
  Future<void> insertBulk(List<T> items) async {
    await DatabaseHelper.database.transaction((txn) async {
      log("yolo this 1");
      final batch = txn.batch();
      for (final e in items) {
        batch.insert(tableName, toJson(e),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit();
    });

    //if (items is List<SignOffItem> && items.isNotEmpty) {
    //  log("${items.length} ${(items[0] as SignOffItem).workOrderId} item(s) inserted in bulk to $tableName");
    //} else {
    //  //log("${items.length} item(s) inserted in bulk to $tableName");
    //}
  }

  /// read item by id
  Future<T?> readById(int id, {List<String>? columnNames}) async {
    final maps = await db.query(tableName,
        columns: columnNames, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return toObject(maps.first);
    } else {
      return null;
    }
  }

  Future<T?> readByForeignKey(
      {List<String>? columnNames, DBValueFilter? filterBy}) async {
    final maps = await db.query(
      tableName,
      columns: columnNames,
      where: filterBy != null ? '${filterBy.columnId} = ?' : null,
      whereArgs: filterBy?.foreignKeys,
    );
    if (maps.isNotEmpty) {
      return toObject(maps.first);
    } else {
      return null;
    }
  }

  Future<List<T>> readListOrdered(
      {String? sortedBy,

      /// use sortBy first before using sortSecondary
      String? sortedBySecondary,
      DBValueFilter? filterBy,
      bool showDeleteChange = false}) async {
    assert(!(sortedBySecondary != null && sortedBy == null),
        "need to use sort by primary first");

    final sqlStr = '''
      SELECT *
      FROM $tableName
      ${filterBy != null && filterBy.foreignKeys.isNotEmpty ? filterBy.foreignKeys.map((e) => "WHERE ${filterBy.columnId} = '$e' ").toList().join('') : ''}
      ${sortedBy != null ? 'ORDER BY datetime("$sortedBy") DESC ${sortedBySecondary != null ? ',datetime("$sortedBySecondary") DESC' : ''} ' : ''}
      ''';

    final maps = await db.rawQuery(sqlStr);

    return maps.map((e) => toObject(e)).toList();
  }

  /// read list of item from table
  Future<List<T>> readList(
      {List<String>? columnNames, DBValueFilter? filterBy}) async {
    final maps = await db.query(
      tableName,
      columns: columnNames,
      where: filterBy != null ? '"${filterBy.columnId}" = ?' : null,
      whereArgs: filterBy?.foreignKeys,
    );

    return maps.map((e) => toObject(e)).toList();
  }

  /// delete item from table by id
  Future<void> deleteById(List<int> items) async {
    final batch = DatabaseHelper.database.batch();

    for (final e in items) {
      batch.rawDelete('DELETE FROM $tableName WHERE id = ?', [e]);
    }
    batch.commit();
  }

//  Future<List<T>> readListByTime(
//      {List<String>? columnNames, DBForeignKeyFilter? filterBy}) async {
//
//    final maps = await db.rawQuery('''
//    SELECT * FROM $tableName
//WHERE created_at between "2021-10-18 00:00:00" and "2021-10-20 23:59:59"
//    ''');
//    return maps.map((e) => toObject(e)).toList();
//  }

  /// read unique of value of single column from table
  Future<List<Object>> readUniqueValuesFromColumn(
      {required String columnName}) async {
    final maps = await db.rawQuery('''
      SELECT DISTINCT $columnName
      FROM $tableName
      ORDER BY $columnName
      ''');

    return maps.map((e) => e[columnName]).whereNotNull().toList();
  }

  /// TODO: implement a migration tools for db changes
  Future<void> migrationToNewVersion() async {
    final Batch batch = DatabaseHelper.database.batch();
    final tempTableName = "${tableName}_temp";
    batch.execute("""
     ${DBHelper.buildCreateTableString(
      tempTableName,
    )}(${DBHelper.buildSqliteIntegerLine(id, isNotNull: !isPKAutoIncrement, isAutoIncrement: isPKAutoIncrement)}
      $createQuery${DBHelper.buildSqlitePrimaryKey(tableNames: primaryKeys, isEnd: foreignKeyAndConstaints == null)}
      ${foreignKeyAndConstaints != null ? foreignKeyAndConstaints!.join(" ") : ""})
    """);
    final itemNew = await DatabaseHelper.database.query(tableName);
    for (final item in itemNew) {
      batch.insert(tempTableName, item);
    }
    batch.execute("""
    DROP $tableName
    """);
    batch.execute("""
    ALTER $tempTableName RENAME To $tableName
    """);
    batch.commit();
  }
}
