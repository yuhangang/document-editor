import 'dart:developer';
import 'package:core/core/model/country/continent.dart';
import 'package:storage/db/base/base_db.dart';
import 'package:storage/db/base/database_helper.dart';
import 'package:storage/db/base/db_schema_util.dart';

enum ContinentTableFields {
  code(SqfField('code',
      fieldType: SqliteFieldType.text, isPk: true, isUnique: true)),
  name(SqfField('name', fieldType: SqliteFieldType.text, isUnique: true));

  final SqfField value;
  const ContinentTableFields(this.value);
}

class ContinentTable extends BaseObjectDBTable<Continent> {
  ContinentTable() : super(tableName: 'Continent');
  @override
  List<SqfField> get fields =>
      ContinentTableFields.values.map((e) => e.value).toList();

  @override
  Continent toObject(Map<String, dynamic> json) => Continent.fromJson(json);

  @override
  Map<String, dynamic> toJson(item) => item.toJson();

  @override
  Future<void> insertBulk(List<Continent> items) async {
    try {
      log("yolo here");
      await DatabaseHelper.database.transaction((txn) async {
        final batch = txn.batch();
        for (final e in items) {
          log("yolo this");
          batch.insert(tableName, toJson(e)..remove('countries'),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
        await batch.commit();
        //for (final e in items) {
        ////  await sl.get<CountryTable>().insertBulk(e.countries);
        //}
      });
    } catch (e) {
      log("Error in insert $e");
    }
    //if (items is List<SignOffItem> && items.isNotEmpty) {
    //  log("${items.length} ${(items[0] as SignOffItem).workOrderId} item(s) inserted in bulk to $tableName");
    //} else {
    //  //log("${items.length} item(s) inserted in bulk to $tableName");
    //}
  }
}
