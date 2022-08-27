import 'package:core/core/model/country/world_city.dart';
import 'package:storage/db/base/base_db.dart';
import 'package:storage/db/base/db_schema_util.dart';

enum CityTableFields {
  name(SqfField('name',
      fieldType: SqliteFieldType.text, isPk: true, isUnique: true)),
  country(SqfField('country',
      fieldType: SqliteFieldType.text, isUnique: true, isEnd: true)),
  lat(SqfField(
    'lat',
    fieldType: SqliteFieldType.number,
  )),
  lng(SqfField('lng', fieldType: SqliteFieldType.number, isEnd: true));

  final SqfField value;
  const CityTableFields(this.value);
}

class CityTable extends BaseObjectDBTable<WorldCity> {
  CityTable() : super(tableName: 'Continent');

  @override
  WorldCity toObject(Map<String, dynamic> json) => WorldCity.fromJson(json);

  @override
  Map<String, dynamic> toJson(item) => item.toJson();

  @override
  String get createQuery => CityTableFields.values
      .map((e) => e.value)
      .map((field) => DBHelper.buildSqlitFieldline(field.name,
          fieldType: field.fieldType,
          isPk: field.isPk,
          isEnd: field.isEnd,
          isNotNull: field.isNotNull))
      .join();
}
