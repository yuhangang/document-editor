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
  @JsonKey(defaultValue: "[]")
  final String data;
  @Index(unique: true)
  final String? documentId;

  DocumentFile(
      {required this.id,
      required this.title,
      this.syncedAt,
      required this.updatedAt,
      required this.createdAt,
      required this.data,
      this.documentId});

  bool get fromServer => documentId != null;

  DocumentFile.create(
      {required String title, required this.data, this.documentId})
      : id = Isar.autoIncrement,
        title = title.trim().isNotEmpty ? title : "Untitled Document",
        createdAt = DateTime.now().toUtc(),
        updatedAt = DateTime.now().toUtc(),
        syncedAt = null;

  DocumentFile clone() {
    return DocumentFile.create(
      title: "$title-copy",
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

  factory DocumentFile.fromJson(Map<String, dynamic> json) {
    return _$DocumentFileFromJson(json);
  }
  Map<String, dynamic> toJson() => _$DocumentFileToJson(this);
}

extension GetUpdateJsonExtension on DocumentFile {
  bool hasUpdate({required String title, required String data}) =>
      (title != this.title) || (data != this.data);

  Map<String, dynamic> getUpdateContent(
      {required String title, required String data}) {
    var map = {
      if (title != this.title) ...{"title": title},
      if (data != this.data) ...{"data": data}
    };
    return map;
  }
}
