import 'package:core/core/db/tables/continent_db.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

abstract class CountryTableFields {
  static const String tableName = 'country';
  static const String code = "code";
  static const String name = "name";
  static const String continent = "continent";
  static const String capital = "capital";
  static const String currency = "currency";
  static const String languages = "languages";
}

const countryTable = SqfEntityTable(
    tableName: CountryTableFields.tableName,
    primaryKeyName: CountryTableFields.name,
    useSoftDeleting: false,
    primaryKeyType: PrimaryKeyType.text,

    // declare fields
    fields: [
      SqfEntityField('native', DbType.text, isNotNull: true),
      //SqfEntityField('phone', DbType.text,isNotNull: true),
      SqfEntityField('capital', DbType.text, isNotNull: true),
      SqfEntityFieldRelationship(
        parentTable: continentTable,
        relationType: RelationType.ONE_TO_MANY,
        deleteRule: DeleteRule.CASCADE,
        fieldName: CountryTableFields.continent,
      ),
      //SqfEntityField('currency', DbType.text, isNotNull: true),
      //SqfEntityField('languages', DbType.text, isNotNull: true),
    ]);
