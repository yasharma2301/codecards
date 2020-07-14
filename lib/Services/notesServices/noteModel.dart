import 'package:hive/hive.dart';

part 'noteModel.g.dart';

@HiveType(typeId: 33)
class NoteModel extends HiveObject{
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

  NoteModel(
      {this.title,
      this.description,
      this.starred,
      this.createdDateTime,
      this.updatedDateTime});
}
