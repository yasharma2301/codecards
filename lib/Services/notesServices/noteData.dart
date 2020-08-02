import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'noteModel.dart';

class NoteData extends ChangeNotifier {
  static const _boxName = 'notesBox';
  List<NoteModel> _noteModel = [];
  int index;

  Future<List<NoteModel>> getNoteList() async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    _noteModel = box.values.toList();
    return _noteModel;
  }

  Future<List<NoteModel>> getStarFiltered() async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    _noteModel = box.values.where((element) => element.starred = true);
    return _noteModel;
  }

  void putNoteAt(int index , NoteModel noteModel) async{
    var box = await Hive.openBox<NoteModel>(_boxName);
    // replace putAt with something else
    box.putAt(index, noteModel);
  }

  NoteModel getNote(index) {
    return _noteModel[index];
  }

  Future<int> addNote(NoteModel note) async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    await box.add(note).then((value) {index = value;});
    _noteModel = box.values.toList();
    notifyListeners();
    return index;
  }

  void deleteNote(key) async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    await box.delete(key);
    _noteModel = box.values.toList();
    notifyListeners();
  }

  void editNote({NoteModel note, int noteKey}) async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    await box.put(noteKey, note);
    _noteModel = box.values.toList();
    notifyListeners();
  }

  int get noteCount {
    return _noteModel.length;
  }
}
