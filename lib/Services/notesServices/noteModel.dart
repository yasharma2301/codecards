import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'noteModel.g.dart';

@HiveType(typeId: 33)
class NoteModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool starred;
  @HiveField(3)
  DateTime createdDateTime;
  @HiveField(4)
  DateTime updatedDateTime;
  String noteId;

  NoteModel(
      {this.title,
      this.description,
      this.starred,
      this.createdDateTime,
      this.updatedDateTime,
      this.noteId});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        title: json['title'] as String,
        description: json['description'] as String,
        starred: json['starred'] as bool,
        createdDateTime: DateTime.parse(json['createdDateTime']),
        updatedDateTime: DateTime.parse(json['updatedDateTime']),
        noteId: json['noteId'] as String);
  }

  @override
  List<Object> get props =>
      [title, description, starred];
}
