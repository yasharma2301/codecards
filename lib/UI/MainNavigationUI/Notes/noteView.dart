import 'package:codecards/Services/notesServices/noteData.dart';
import 'package:codecards/Services/notesServices/noteModel.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/Login/newLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
enum NoteModes { Editing, Adding }

class NoteView extends StatefulWidget {
  final NoteModel noteModel;
  final NoteModes noteMode;

  const NoteView({Key key, this.noteModel, this.noteMode}) : super(key: key);

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  String title;
  String description;
  bool starred;
  DateTime createdDateTime;
  DateTime updatedDateTime;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.noteMode == NoteModes.Editing) {
      _titleController.text = widget.noteModel.title;
      title = widget.noteModel.title;
      _descriptionController.text = widget.noteModel.description;
      description = widget.noteModel.description;
      updatedDateTime = widget.noteModel.updatedDateTime;
      createdDateTime = widget.noteModel.createdDateTime;
      starred = widget.noteModel.starred;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _editAssociate(context) {
      Provider.of<NoteData>(context, listen: false).editNote(
        note: NoteModel(
            title: title,
            description: description,
            starred: starred,
            createdDateTime: createdDateTime,
            updatedDateTime: DateTime.now()),
        noteKey: widget.noteModel.key,
      );

      Navigator.pop(context);
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<NoteData>(
      builder: (context, noteData, child) {
        NoteModel _currentNote = noteData.getActiveNote();
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
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: height / 4.5,
                      padding: const EdgeInsets.only(top: 30),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 20,
                            bottom: 10,
                            child: Material(
                              child: Text(
                                widget.noteMode == NoteModes.Editing
                                    ? "Edit notes".toUpperCase()
                                    : "Add a note".toUpperCase(),
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
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: LightGrey.withOpacity(0.7),
                        ),
                        child: TextFormField(
                          controller: _titleController,
                          onChanged: (v) {
                            setState(() {
                              title = v;
                            });
                          },
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
                          onChanged: (v) {
                            setState(() {
                              description = v;
                            });
                          },
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
                        if (widget.noteMode == NoteModes.Editing) {
                          _editAssociate(context);
                        } else {
                          Provider.of<NoteData>(context, listen: false).addNote(
                            NoteModel(
                                title: _titleController.text,
                                starred: false,
                                description: _descriptionController.text,
                                createdDateTime: DateTime.now(),
                                updatedDateTime: DateTime.now()),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      child: ClipPath(
                        clipper: LoginClipper(),
                        child: Container(
                          width: width / 1.7,
                          height: height / 11,
                          color: Color(0xFFF95A5F).withOpacity(0.8),
                          child: Center(
                            child: Text(
                              NoteModes.Editing == widget.noteMode
                                  ? "Update"
                                  : "Save",
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
      },
    );
  }
}
