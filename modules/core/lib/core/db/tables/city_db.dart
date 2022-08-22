import 'package:core/core/db/tables/country_db.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

abstract class CityTableFields {
  static const String tableName = 'city';
  static const String name = "name";
  static const String country = "country";
}

const cityTable = SqfEntityTable(
    tableName: CityTableFields.tableName,
    primaryKeyName: CityTableFields.name,
    useSoftDeleting: false,
    primaryKeyType: PrimaryKeyType.text,
    // declare fields
    fields: [
      SqfEntityFieldRelationship(
        parentTable: countryTable,
        relationType: RelationType.ONE_TO_MANY,
        deleteRule: DeleteRule.CASCADE,
        fieldName: CityTableFields.country,
      ),
    ]);
