import 'package:core/core/model/country/world_city.dart';
import 'package:storage/db/base/base_db.dart';
import 'package:storage/db/base/db_schema_util.dart';

enum CityTableFields {
  name(SqfField('name',
      fieldType: SqliteFieldType.text, isPk: true, isUnique: true)),
  native(SqfField('native', fieldType: SqliteFieldType.text)),
  capital(SqfField('capital', fieldType: SqliteFieldType.text)),
  country(SqfFieldWithRelation('countryID',
      fieldType: SqliteFieldType.text,
      isUnique: true,
      foreignTableName: 'country',
      foreignTableColumnName: 'name')),
  lat(SqfField(
    'lat',
    fieldType: SqliteFieldType.number,
  )),
  lng(SqfField('lng', fieldType: SqliteFieldType.number));

  final SqfField value;
  const CityTableFields(this.value);
}

class CityTable extends BaseObjectDBTable<WorldCity> {
  CityTable() : super(tableName: 'City');
  @override
  List<SqfField> get fields =>
      CityTableFields.values.map((e) => e.value).toList();

  @override
  WorldCity toObject(Map<String, dynamic> json) => WorldCity.fromJson(json);

  @override
  Map<String, dynamic> toJson(item) => item.toJson();
}
