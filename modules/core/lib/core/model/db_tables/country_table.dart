import 'package:core/core/model/country/country.dart';
import 'package:storage/db/base/base_db.dart';
import 'package:storage/db/base/db_schema_util.dart';

enum CountryTableFields {
  code(SqfField('code',
      fieldType: SqliteFieldType.text, isPk: true, isUnique: true)),
  name(SqfField('name', fieldType: SqliteFieldType.text, isUnique: true)),
  native(SqfField('native', fieldType: SqliteFieldType.text, isUnique: true)),
  continent(SqfFieldWithRelation('continent',
      fieldType: SqliteFieldType.text,
      foreignTableName: 'continent',
      foreignTableColumnName: 'name')),
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
}
