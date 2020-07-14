import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class NoteProvider {
  static Database db;

  static Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'notes.db'),
        version: 1, onCreate: (Database db, int version) async {
      db.execute('''
          create table Notes(
            id integer primary key autoincrement,
            title text not null,
            description text not null,
            starred integer not null,
            createdDateTime integer not null,
            updatedDateTime integer not null
          );
        ''');
    });
  }

  static Future<List<Map<String, dynamic>>> getNoteList() async {
    if (db == null) {
      await open();
    }
    return await db.query('Notes');
  }

  static Future insertNote(Map<String, dynamic> note) async {
    await db.insert('Notes', note);
  }

  static Future updateNote(Map<String, dynamic> note) async {
    await db.update('Notes', note, where: 'id = ?', whereArgs: [note['id']]);
  }

  static Future deleteNote(int id) async {
    await db.delete('Notes', where: 'id = ?', whereArgs: [id]);
  }
}

//class DatabaseHelper {
//
//  static DatabaseHelper _databaseHelper;
//  static Database _database;
//
//  String noteTable = 'note_table';
//  String colId = 'id';
//  String colTitle = 'title';
//  String colDescription = 'description';
//  String colStarred = 'starred';
//  String colCreatedDateTime = 'createdDateTime';
//  String colUpdatedDateTime = 'updatedDateTime';
//
//
//  DatabaseHelper._createInstance();
//
//  factory DatabaseHelper() {
//
//    if (_databaseHelper == null) {
//      _databaseHelper = DatabaseHelper._createInstance();
//    }
//    return _databaseHelper;
//  }
//
//  Future<Database> get database async {
//
//    if (_database == null) {
//      _database = await initializeDatabase();
//    }
//    return _database;
//  }
//
//  Future<Database> initializeDatabase() async {
//    Directory directory = await getApplicationDocumentsDirectory();
//    String path = directory.path + 'notes.db';
//
//    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
//    return notesDatabase;
//  }
//
//  void _createDb(Database db, int newVersion) async {
//
//    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
//        '$colDescription TEXT, $colStarred INTEGER, $colCreatedDateTime INTEGER, $colUpdatedDateTime INTEGER)');
//  }
//
//  Future<List<Map<String, dynamic>>> getNoteMapList() async {
//    Database db = await this.database;
//
//    var result = await db.query(noteTable);
//    return result;
//  }
//
//  Future<int> insertNote(NotesModel note) async {
//    Database db = await this.database;
//    var result = await db.insert(noteTable, note.toMap());
//    return result;
//  }
//
//  Future<int> updateNote(NotesModel note) async {
//    var db = await this.database;
//    var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
//    return result;
//  }
//
//  Future<int> deleteNote(int id) async {
//    var db = await this.database;
//    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
//    return result;
//  }
//
//  Future<int> getCount() async {
//    Database db = await this.database;
//    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }
//
//  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
//  Future<List<NotesModel>> getNoteList() async {
//
//    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
//    int count = noteMapList.length;         // Count the number of map entries in db table
//
//    List<NotesModel> noteList = List<NotesModel>();
//    // For loop to create a 'Note List' from a 'Map List'
//    for (int i = 0; i < count; i++) {
//      noteList.add(NotesModel.fromMapObject(noteMapList[i]));
//    }
//
//    return noteList;
//  }
//
//}
