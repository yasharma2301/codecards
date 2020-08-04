import 'dart:convert';
import 'noteModel.dart';
import 'package:http/http.dart' as http;

class NoteAPIServerClass {
  // final String url = 'http://192.168.0.7:8000/notes/
  final String url = 'http://192.168.0.7:8000/notes/';

  void postNoteToServer(NoteModel note, String userToken, int id) async {
    var body = {
      'noteId': '$userToken-$id',
      'title': note.title.toString(),
      'description': note.description.toString(),
      'starred':
          '${note.starred.toString()[0].toUpperCase()}${note.starred.toString().substring(1)}',
      'createdDateTime': note.createdDateTime.toString(),
      'updatedDateTime': note.updatedDateTime.toString(),
      'userToken': userToken.toString()
    };

    var result = await http.post(url, body: body);
    Map response = json.decode(result.body);
    if (result.statusCode == 201) {
      print(response['message']);
    } else {
      print(response['error_message']);
    }
  }

  void updateNoteToServer(NoteModel note, String userToken, int id) async {
    var body = {
      'noteId': '$userToken-$id',
      'title': note.title.toString(),
      'description': note.description.toString(),
      'starred':
          '${note.starred.toString()[0].toUpperCase()}${note.starred.toString().substring(1)}',
      'updatedDateTime': note.updatedDateTime.toString(),
    };
    var result = await http.put(
      url,
      body: body,
      headers: {
        'userToken': userToken,
      },
    );
    Map response = json.decode(result.body);
    if (result.statusCode == 201) {
      print(response['message']);
    } else {
      print(response['error_message']);
    }
  }

  void deleteNoteFromServer(int id, String userToken) async {
    var result = await http.delete(url, headers: {'noteId': '$userToken-$id'});
    Map response = json.decode(result.body);
    if (result.statusCode == 200) {
      print(response['message']);
    } else {
      print(response['error_message']);
    }
  }

  Future<List<NoteModel>> getListOfNotesFromServer(String userToken) async {
    var result = await http.get(url, headers: {'userToken': userToken});
    final response = jsonDecode(result.body);
    if (result.statusCode == 200) {
      List<NoteModel> notesList = List<NoteModel>.from(
          response.map((item) => NoteModel.fromJson(item)));
      return notesList;
    } else {
      print(response['error_message']);
    }
  }
}
