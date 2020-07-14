import 'dart:math';
import 'package:codecards/Services/notesServices/noteData.dart';
import 'package:codecards/Services/notesServices/noteModel.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/MainNavigationUI/Notes/notes_dialog.dart';
import 'package:codecards/UI/Settings/settings2.dart';
import 'package:codecards/routes/slideFromRight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Bloc/navigation_bloc.dart';
import 'CardsLogic/cards.dart';

class CodeCards extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const CodeCards({Key key, this.onMenuTap}) : super(key: key);

  @override
  _CodeCardsState createState() => _CodeCardsState();
}

class _CodeCardsState extends State<CodeCards> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double currentWidth = constraints.constrainWidth();
        double maxWidth = MediaQuery.of(context).size.width;
        bool border;
        if (maxWidth == currentWidth) {
          border = false;
        } else {
          border = true;
        }
        return Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: PopBlue.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 1)
              ],
              borderRadius:
                  border ? BorderRadius.circular(40) : BorderRadius.circular(0),
              color: Grey),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: border == true
                  ? EdgeInsets.only(top: 30, left: 15)
                  : EdgeInsets.only(top: 30),
              child: Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: border == true
                              ? EdgeInsets.only(left: 0)
                              : EdgeInsets.only(left: 12),
                          child: IconButton(
                            splashColor: LightPopBlue.withOpacity(0.5),
                            hoverColor: LightPopBlue,
                            highlightColor: Colors.transparent,
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: widget.onMenuTap,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              splashColor: LightPopBlue.withOpacity(0.5),
                              hoverColor: LightPopBlue,
                              highlightColor: Colors.transparent,
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    SlideFromRightPageRoute(page: Settings()));
                              }),
                        )
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          IgnorePointer(
                            ignoring: border == true ? true : false,
                            child: Container(
                              child: CardsStack(),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: GestureDetector(
                                onTap: () {
                                  _bringUpNotesSheet(context);
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white24,
                                        offset: Offset(0, 0),
                                        blurRadius: 10,
                                      )
                                    ],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Theme.of(context).primaryColor,
                                          Theme.of(context).primaryColorLight
                                        ],
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight,
                                        tileMode: TileMode.repeated),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: White,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _bringUpNotesSheet(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStatee) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                  color: Grey,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              child: Scaffold(
                body: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white24,
                            offset: Offset(0, 0),
                            blurRadius: 10,
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColorLight
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.topRight,
                            tileMode: TileMode.repeated),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Notes',
                              style: TextStyle(
                                  color: Grey.withOpacity(0.9),
                                  fontSize: 30,
                                  fontFamily: 'Nunito Black'),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.star_border,
                                  color: Grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 70),
                            child: FutureBuilder(
                              future:
                                  Provider.of<NoteData>(context).getNoteList(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return NoteTile(titleIndex: index);
                                    },
                                    itemCount: Provider.of<NoteData>(context)
                                        .noteCount,
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NoteView(
                                  noteMode: NoteModes.Adding,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).primaryColorLight
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.topRight,
                                  tileMode: TileMode.repeated),
                            ),
                            child: Icon(
                              Icons.add,
                              color: White,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
//                    Positioned(
//                      left: -width/3.5,
//                      top: height/3-80,
//                      child: Transform.rotate(
//                        angle: -pi/2,
//                        child: Row(
//                          mainAxisSize: MainAxisSize.min,
//                          children: [
//                            FlatButton(
//                              onPressed: () {},
//                              child: Container(
//                                height: 30,
//                                width: 100,
//                                child: Center(
//                                  child: Text(
//                                    'Starred',
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 20),
//                                  ),
//                                ),
//                              ),
//                            ),
//                            FlatButton(
//                              onPressed: () {},
//                              child: Container(
//                                height: 30,
//                                width: 100,
//                                child: Center(
//                                  child: Text(
//                                    'Notes',
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 20),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class NoteTile extends StatefulWidget {
  final int titleIndex;

  const NoteTile({Key key, this.titleIndex}) : super(key: key);

  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, noteData, child) {
        NoteModel curNote = noteData.getNote(widget.titleIndex);
        return Dismissible(
          direction: DismissDirection.startToEnd,
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              var note = Provider.of<NoteData>(context, listen: false)
                  .getNote(widget.titleIndex)
                  .key;
              Provider.of<NoteData>(context, listen: false).deleteNote(note);
            });
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: widget.titleIndex % 2 == 0 ? 50 : 55, bottom: 15),
            child: Material(
              elevation: 15,
              child: Container(
                height: 92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  color: LightGrey.withOpacity((0.8)),
                ),
                child: ListTile(
                  onTap: () {
                    Provider.of<NoteData>(context, listen: false)
                        .setActiveNote(curNote.key);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NoteView(
                          noteModel: curNote,
                          noteMode: NoteModes.Editing,
                        ),
                      ),
                    );
                  },
                  title: Text(
                    '${widget.titleIndex + 1}. ${curNote.title}',
                    style: TextStyle(
                        color: Grey, fontSize: 22, fontFamily: 'Nunito Black'),
                  ),
                  subtitle: Text(
                    curNote.description.length > 50
                        ? curNote.description.substring(0, 50) + ' ...'
                        : curNote.description,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Nunito Black'),
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                                color: curNote.starred == true
                                    ? Colors.white12
                                    : Colors.transparent,
                                blurRadius: 8)
                          ]),
                          child: IconButton(
                            icon: Icon(
                              curNote.starred == true
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 30,
                              color: curNote.starred == true
                                  ? Colors.yellow
                                  : Grey,
                            ),
                            onPressed: () {
                              print(curNote.starred);
                              Provider.of<NoteData>(context, listen: false)
                                  .editNote(
                                      note: NoteModel(
                                          title: curNote.title,
                                          description: curNote.description,
                                          starred: curNote.starred == true
                                              ? false
                                              : true,
                                          createdDateTime:
                                              curNote.createdDateTime,
                                          updatedDateTime: DateTime.now()),
                                      noteKey: curNote.key);
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

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
