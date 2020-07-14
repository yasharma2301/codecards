import 'package:codecards/Services/notesServices/noteData.dart';
import 'package:codecards/Services/notesServices/noteModel.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'noteView.dart';
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
