class DBValueFilter {
  final String columnId;
  final List<Object> foreignKeys;

  DBValueFilter({
    required this.columnId,
    required this.foreignKeys,
  });
}
