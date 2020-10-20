import 'package:codecards/Services/notesServices/noteAPIService.dart';
import 'package:codecards/Services/notesServices/noteData.dart';
import 'package:codecards/Services/notesServices/noteModel.dart';
import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codecards/Shared/themesEnum.dart';
import 'package:codecards/UI/MainNavigationUI/MenuDashboardLayout/menu_dashboard.dart';
import 'package:codecards/UI/OnBoard/onBoardNew.dart';
import 'package:codecards/UI/Settings/Avatar/avatar.dart';
import 'package:codecards/UI/Settings/Contact_US/Contact_US.dart';
import 'package:codecards/UI/Settings/settings2.dart';
import 'package:flutter/foundation.dart';

import 'Services/Themes/accentColorProvider.dart';

class MyHomePage extends StatelessWidget {
  final String initialRoute;

  const MyHomePage({Key key, this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    final NoteData noteData = Provider.of<NoteData>(context);
    final UserRepository userRepository = Provider.of<UserRepository>(context);

    // Parallel computation using isolates will be better but can't do in current case
    // compute(syncServerAndHiveNotes,List<dynamic>[noteData,userRepository]);

    // syncServerAndHiveNotes(noteData, userRepository);

    // Ye kyun hai yahan
    Future.delayed(Duration(milliseconds: 1400));

    return MaterialApp(
      title: 'CodeCards',
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => OnBoardNew(),
        'menuDashBoard': (context) => MenuDashboardPage(),
        '/settings2': (context) => Settings(),
        'avatar': (context) => Avatar(),
        'contact_us': (context) => ContactUs()
      },
    );
  }
}

List<NoteModel> hiveNoteList, serverNoteList;

void syncServerAndHiveNotes(
    NoteData noteData, UserRepository userRepository) async {
  NoteAPIServerClass noteAPIServerClass = NoteAPIServerClass();
  await noteData.getNoteList().then((value) {
    hiveNoteList = value;
  });
  // server to Hive sync
  await noteAPIServerClass
      .getListOfNotesFromServer(userRepository.userToken)
      .then(
    (value) {
      serverNoteList = value;
      value.forEach(
        (element) async {
          if (!hiveNoteList.contains(element)) {
            await noteData.addNote(element).then(
              (id) async {
                print(id);
                noteAPIServerClass.postNoteToServer(
                    element, userRepository.userToken, id);
                noteAPIServerClass.deleteNoteFromServer(
                    int.parse(element.noteId.toString().substring(
                        element.noteId.toString().lastIndexOf('-') + 1)),
                    userRepository.userToken);
              },
            );
          }
        },
      );
    },
  );
  // Hive to server sync
  await noteData.getNoteList().then(
    (value) {
      value.forEach(
        (element) {
          if (!serverNoteList.contains(element)) {
            noteAPIServerClass.postNoteToServer(
                element, userRepository.userToken, element.key);
          }
        },
      );
    },
  );
}
