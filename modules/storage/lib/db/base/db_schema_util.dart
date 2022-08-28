enum SqlOnDeleteConstraint {
  none(""),
  cascade("ON DELETE CASCADE");

  final String value;
  const SqlOnDeleteConstraint(this.value);
}

enum SqliteFieldType {
  text('TEXT'),
  number('NUMBER');

  final String value;
  const SqliteFieldType(this.value);
}

class SqfFieldWithRelation extends SqfField {
  final String foreignTableColumnName;
  final String foreignTableName;
  final SqlOnDeleteConstraint constraint;
  const SqfFieldWithRelation(
    super.name, {
    required super.fieldType,
    super.isPk = false,
    super.isNotNull = true,
    super.isUnique = false,
    required this.foreignTableColumnName,
    required this.foreignTableName,
    this.constraint = SqlOnDeleteConstraint.cascade,
  });

  String get relationText => "FOREIGN KEY ($name) REFERENCES $foreignTableName "
      "($foreignTableColumnName) "
      "${constraint.value} ";
}

class SqfField {
  final String name;
  final SqliteFieldType fieldType;
  final bool isPk;
  final bool isNotNull;
  final bool isUnique;

  const SqfField(this.name,
      {required this.fieldType,
      this.isPk = false,
      this.isNotNull = true,
      this.isUnique = false});

  @override
  String toString() {
    return "$name ${fieldType.value}${isPk ? ' PRIMARY KEY' : ''}"
        "${isNotNull ? ' NOT NULL' : ''}";
  }
}

abstract class DBHelper {
  static String buildCreateTableString(String table) {
    return "CREATE TABLE IF NOT EXISTS $table";
  }

  static String buildSqlitFieldline(String column,
          {required SqliteFieldType fieldType,
          bool isPk = false,
          bool isEnd = false,
          bool isNotNull = false}) =>
      "$column ${fieldType.value}${isPk ? ' PRIMARY KEY' : ''}"
      "${isNotNull ? ' NOT NULL' : ''}${isEnd ? '' : ',\n'}";

  static String buildSqliteBlobLine(String column,
          {bool isPk = false, bool isEnd = false, bool isNotNull = false}) =>
      "$column BLOB${isPk ? ' PRIMARY KEY' : ''}"
      "${isNotNull ? ' NOT NULL' : ''}"
      "${isEnd ? '' : ',\n'}";

  static String buildSqliteUniqueConstraints(
      {required List<String> tableNames}) {
    assert(tableNames.length >= 2);
    return "UNIQUE(${tableNames.join(", ")})";
  }

  static String buildSqliteIntegerLine(String column,
      {bool isPk = false,
      bool isEnd = false,
      bool isAutoIncrement = false,
      bool isNotNull = false}) {
    return "$column INTEGER"
        "${isPk ? ' PRIMARY KEY ' : ''}"
        "${isAutoIncrement ? "AUTOINCREMENT" : ''}"
        "${isNotNull ? ' NOT NULL' : ''}${isEnd ? '' : ',\n'}";
  }

  static String buildSqliteForeignKey(String column,
      {String? foreignTableColumnName,
      bool isPk = false,
      bool isEnd = false,
      bool isAutoIncrement = false,
      SqlOnDeleteConstraint constraint = SqlOnDeleteConstraint.none,
      required String foreignTableName}) {
    return "FOREIGN KEY ($column) REFERENCES $foreignTableName "
        "(${foreignTableColumnName ?? column}) "
        "${constraint.value} "
        "${isEnd ? '' : ',\n'}";
  }

  static String buildSqlitePrimaryKey(
      {bool isPk = false,
      bool isEnd = false,
      bool isAutoIncrement = false,
      required List<String> tableNames}) {
    assert(tableNames.isNotEmpty);
    return "PRIMARY KEY (${List.generate(tableNames.length, (index) => "${tableNames[index]} "
            "${index < tableNames.length - 1 ? "," : ""}").join("")})  "
        "${isEnd ? '' : ',\n'}";
  }
}
