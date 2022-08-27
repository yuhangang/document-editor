import 'package:core/core/model/country/continent.dart';
import 'package:storage/db/base/base_db.dart';
import 'package:storage/db/base/db_schema_util.dart';

enum ContinentTableFields {
  code(SqfField('code',
      fieldType: SqliteFieldType.text, isPk: true, isUnique: true)),
  name(SqfField('name',
      fieldType: SqliteFieldType.text, isUnique: true, isEnd: true));

  final SqfField value;
  const ContinentTableFields(this.value);
}

class ContinentTable extends BaseObjectDBTable<Continent> {
  ContinentTable() : super(tableName: 'Continent');

  @override
  Continent toObject(Map<String, dynamic> json) => Continent.fromJson(json);

  @override
  Map<String, dynamic> toJson(item) => item.toJson();

  @override
  String get createQuery => ContinentTableFields.values
      .map((e) => e.value)
      .map((field) => DBHelper.buildSqlitFieldline(field.name,
          fieldType: field.fieldType,
          isPk: field.isPk,
          isEnd: field.isEnd,
          isNotNull: field.isNotNull))
      .join();
}
