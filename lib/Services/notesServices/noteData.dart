import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'noteModel.dart';

class NoteData extends ChangeNotifier {
  static const _boxName = 'notesBox';
  List<NoteModel> _noteModel = [];
  NoteModel _activeNote;

  void getNotes() async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    _noteModel = box.values.toList();
    notifyListeners();
  }

  Future<List<NoteModel>> getNoteList() async{
    var box = await Hive.openBox<NoteModel>(_boxName);
    _noteModel = box.values.toList();
    return _noteModel;
  }

  //Work Here ---!Incomplete!---
  Future<List<NoteModel>> getStarFilter() async{
    var box = await Hive.openBox<NoteModel>(_boxName);
   _noteModel = box.values.where((element) => element.starred==true);
    return _noteModel;
  }


  NoteModel getNote(index) {
    return _noteModel[index];
  }

  void addNote(NoteModel note) async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    await box.add(note);
    _noteModel = box.values.toList();
    notifyListeners();
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
    _activeNote = box.get(noteKey);
    notifyListeners();
  }

  void setActiveNote(key) async {
    var box = await Hive.openBox<NoteModel>(_boxName);
    _activeNote = box.get(key);
    notifyListeners();
  }

  NoteModel getActiveNote() {
    return _activeNote;
  }

  int get noteCount {
    return _noteModel.length;
  }
}
