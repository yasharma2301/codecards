import 'package:codecards/UI/MainNavigationUI/MenuDashboardLayout/menu_dashboard.dart';
import 'package:codecards/UI/Settings/settings2.dart';
import 'package:flutter/material.dart';
import 'UI/OnBoard/onBoardingScreen.dart';
import 'UI/Login/loginScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    initializing();
    _showNotifications();
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications() async {
    await notification();
  }

  Future<void> notification() async {
    var time = Time(19, 36, 50);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'id', 'CodeCards', 'Reminder to code daily',
        priority: Priority.High, importance: Importance.Max);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Reminder',
        'Problems await coder, open CodeCards and swipe to solve',
        time,
        platformChannelSpecifics);
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }

    // we can set navigator to navigate another screen
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Cards',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => OnBoard(),
        'login': (context) => LoginScreen(),
        'menuDashBoard': (context) => MenuDashboardPage(),
        '/settings2': (context) => Settings(),
      },
    );
  }
}

class Trials extends StatefulWidget {
  @override
  _TrialsState createState() => _TrialsState();
}

class _TrialsState extends State<Trials> {
  TimeOfDay time = TimeOfDay(hour: 11, minute: 20);

  // TimeOfDay picked;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () async {
          // showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2040));
          TimeOfDay picked =
              await showTimePicker(context: context, initialTime: time);
          setState(() {
            time = picked;
          });
        },
        color: Colors.deepPurpleAccent,
        splashColor: Colors.purpleAccent,
        child: Text(
          time.format(context),
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
