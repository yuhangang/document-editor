import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@collection
class DocumentFile {
  Id id;
  final String title;
  final DateTime? syncedAt;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String data;
  DocumentFile({
    required this.id,
    required this.title,
    this.syncedAt,
    required this.updatedAt,
    required this.createdAt,
    required this.data,
  });

  DocumentFile.create({
    required String title,
    required this.data,
  })  : id = Isar.autoIncrement,
        title = title.trim().isNotEmpty ? title : "Untitled Document",
        createdAt = DateTime.now().toUtc(),
        updatedAt = DateTime.now().toUtc(),
        syncedAt = null;

  DocumentFile clone() {
    return DocumentFile.create(
      title: "$title Copy",
      data: data,
    );
  }

  DocumentFile copyWith({
    Id? id,
    String? title,
    DateTime? syncedAt,
    DateTime? createdAt,
    String? data,
  }) {
    return DocumentFile(
      id: id ?? this.id,
      title: title ?? this.title,
      syncedAt: syncedAt ?? this.syncedAt,
      updatedAt: DateTime.now().toUtc(),
      createdAt: createdAt ?? this.createdAt,
      data: data ?? this.data,
    );
  }
}

/*
@embedded
class FileEditEvent {
  final int id;
  final DateTime time;
  final DateTime? syncedAt;
}
*/
