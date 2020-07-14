import 'package:codecards/Services/notesServices/noteInherited.dart';
import 'package:codecards/Services/notesServices/noteProvider.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/delayed_animation.dart';
import 'package:flutter/material.dart';

enum NoteMode { Editing, Adding }

class NotesDialog extends StatefulWidget {
  final NoteMode noteMode;

  final Map<String, dynamic> noteModel;

  const NotesDialog({Key key, this.noteMode, this.noteModel}) : super(key: key);

  @override
  _NotesDialogState createState() => _NotesDialogState();
}

class _NotesDialogState extends State<NotesDialog> {
//  List<Map<String, dynamic>> get _notes =>
//      NoteInheritedWidget.of(context).notes;

  Size size;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();


  @override
  void didChangeDependencies() {
    if (widget.noteMode == NoteMode.Editing) {
      _titleController.text = widget.noteModel['title'];
      _descriptionController.text = widget.noteModel['description'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Grey,
      body: Stack(
        children: [
          Container(
            color: LightGrey.withOpacity(0.15),
          ),
          Positioned(
            left: -(height / 2 - width / 2),
            top: -height * 0.2,
            child: Container(
              height: height,
              width: height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: LightGrey.withOpacity(0.43),
              ),
            ),
          ),
          Positioned(
            left: width * 0.15,
            top: -width * 0.5,
            child: Container(
              height: width * 1.6,
              width: width * 1.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: LightGrey.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            right: -width * 0.2,
            top: -50,
            child: Container(
              height: width * 0.6,
              width: width * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: LightGrey.withOpacity(0.3),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  width: width,
                  height: height / 4.5,
                  padding: const EdgeInsets.only(top: 30),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 10,
                        child: Material(
                          child: Text(
                            widget.noteMode == NoteMode.Adding
                                ? "Add a note".toUpperCase()
                                : "Edit notes".toUpperCase(),
                            style: TextStyle(
                                color: White,
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: width - 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Grey, borderRadius: BorderRadius.circular(6)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: LightGrey.withOpacity(0.7),
                    ),
                    child: TextFormField(
                      controller: _titleController,
                      cursorColor: Theme.of(context).primaryColorLight,
                      style: TextStyle(
                        color: White.withOpacity(0.9),
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter a title.",
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: width - 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Grey, borderRadius: BorderRadius.circular(6)),
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: LightGrey.withOpacity(0.7),
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 8,
                      cursorColor: Theme.of(context).primaryColorLight,
                      style: TextStyle(
                          fontSize: 18, color: White.withOpacity(0.9)),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Description.",
                          alignLabelWithHint: true,
                          hintStyle: TextStyle(
                              fontSize: 17,
                              height: 0.5,
                              color: Colors.white.withOpacity(0.7))),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    final title = _titleController.text;
                    final description = _descriptionController.text;

                    if (widget?.noteMode == NoteMode.Adding) {
                      NoteProvider.insertNote(
                        {
                          'title': title,
                          'description': description,
                          "createdDateTime": 2,
                          "updatedDateTime": 3,
                          "starred": 1,
                        },
                      );
                    } else if (widget?.noteMode == NoteMode.Editing) {
                      NoteProvider.updateNote({
                        'id': widget.noteModel['id'],
                        'title': _titleController.text,
                        'description': description,
                       });
                    }
                    Navigator.pop(context);
                  },
                  child: ClipPath(
                    clipper: LoginClipper(),
                    child: Container(
                      width: width / 1.7,
                      height: height / 11,
                      color: Color(0xFFF95A5F).withOpacity(0.8),
                      child: Center(
                        child: Text(
                          widget.noteMode == NoteMode.Adding
                              ? "Save"
                              : "Update",
                          style: TextStyle(color: White, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 50,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(10)),
                  color: Grey,
                ),
                child: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double roundnessFactor = 30.0;

    var path = Path();

    path.moveTo(size.width * 0.09, size.height * 0.0);

    path.lineTo(10, size.height - roundnessFactor);
    path.quadraticBezierTo(5, size.height, roundnessFactor, size.height);

    path.lineTo(size.width - roundnessFactor * 0.8, size.height * 0.83);
    path.quadraticBezierTo(
        size.width, size.height * 0.8, size.width, size.height * 0.6);

    path.lineTo(size.width, size.height * 0.45);
    path.quadraticBezierTo(size.width, size.height * 0.2,
        size.width - roundnessFactor * 0.7, size.height * 0.2);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
