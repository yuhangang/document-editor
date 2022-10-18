import 'package:core/core/di/service_locator.dart';
import 'package:core/core/model/country/country.dart';
import 'package:core/core/model/db_tables/city_table.dart';
import 'package:storage/db/base/base_db.dart';
import 'package:storage/db/base/database_helper.dart';
import 'package:storage/db/base/db_schema_util.dart';

enum CountryTableFields {
  code(SqfField('code',
      fieldType: SqliteFieldType.text, isPk: true, isUnique: true)),
  name(SqfField('name', fieldType: SqliteFieldType.text, isUnique: true)),
  native(SqfField('native', fieldType: SqliteFieldType.text, isUnique: true)),
  continent(SqfFieldWithRelation('continentID',
      fieldType: SqliteFieldType.text,
      foreignTableName: 'continent',
      foreignTableColumnName: 'code')),
  capital(SqfField('capital', fieldType: SqliteFieldType.text, isUnique: true));

  final SqfField value;
  const CountryTableFields(this.value);
}

class CountryTable extends BaseObjectDBTable<Country> {
  CountryTable() : super(tableName: 'Country');
  @override
  List<SqfField> get fields =>
      CountryTableFields.values.map((e) => e.value).toList();

  @override
  Country toObject(Map<String, dynamic> json) => Country.fromJson(json);

  @override
  Map<String, dynamic> toJson(item) => item.toJson();

  @override
  Future<void> insertBulk(List<Country> items) async {
    await DatabaseHelper.database.transaction((txn) async {
      final batch = txn.batch();
      for (final e in items) {
        batch.insert(tableName, toJson(e)..remove('cities'),
            conflictAlgorithm: ConflictAlgorithm.replace);
        await sl.get<CityTable>().insertBulk(e.cities);
      }
      await batch.commit();
    });
    //if (items is List<SignOffItem> && items.isNotEmpty) {
    //  log("${items.length} ${(items[0] as SignOffItem).workOrderId} item(s) inserted in bulk to $tableName");
    //} else {
    //  //log("${items.length} item(s) inserted in bulk to $tableName");
    //}
  }
}
