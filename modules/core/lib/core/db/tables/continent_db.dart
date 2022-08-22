import 'package:sqfentity_gen/sqfentity_gen.dart';

abstract class ContinentTableFields {
  static const String tableName = 'continent';
  static const String code = "code";
  static const String name = "name";
}

const continentTable = SqfEntityTable(
    tableName: ContinentTableFields.tableName,
    primaryKeyName: ContinentTableFields.code,
    useSoftDeleting: false,
    primaryKeyType: PrimaryKeyType.text,
    // declare fields
    fields: [
      SqfEntityField(ContinentTableFields.name, DbType.text, isNotNull: true),
    ]);
