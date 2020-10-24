import 'dart:math';
import 'package:codecards/Services/ContestsServices/contestModel.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_calendar/device_calendar.dart';

class ContestDetail extends StatefulWidget {
  final ContestsAPIModel contestsAPIModel;

  const ContestDetail({Key key, this.contestsAPIModel}) : super(key: key);

  @override
  _ContestDetailState createState() => _ContestDetailState();
}

class _ContestDetailState extends State<ContestDetail>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  DeviceCalendarPlugin _deviceCalendarPlugin = new DeviceCalendarPlugin();
  bool hasCalendarPermissions = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String startDate = widget.contestsAPIModel.start.split('T')[0];
    String startTime =
        widget.contestsAPIModel.start.split('T')[1].replaceAll('Z', '');

    String _printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    String timeUntilStart = _printDuration(
        DateTime.parse(widget.contestsAPIModel.start.replaceAll('Z', ''))
            .difference(DateTime.now()));

    String endDate = widget.contestsAPIModel.end.split('T')[0];
    String endTime =
        widget.contestsAPIModel.end.split('T')[1].replaceAll('Z', '');

    String duration =
        (widget.contestsAPIModel.duration.toInt() / 3600).toStringAsFixed(1);

    String host =
        widget.contestsAPIModel.name != 'codingcompetitions.withgoogle.com'
            ? widget.contestsAPIModel.name
            : 'google.com';

    _scale = 1 - _controller.value;
    var height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Container(
            height: height * 0.9,
            width: width,
            decoration: BoxDecoration(
              color: Grey,
            ),
            child: Center(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: padding.top, horizontal: 5),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: White,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.code,
                      size: 300,
                      color: White.withOpacity(0.05),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: padding.top + 20,
                        left: 20,
                        right: 20,
                        bottom: padding.top),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              widget.contestsAPIModel.event,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Until Start :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              // '30:25:12',
                              timeUntilStart,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 44,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'START:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        startDate,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        startTime,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'END:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        endDate,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        endTime,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Duration: $duration hours',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Host: $host',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Link to contest',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.blueAccent[100],
                                      fontFamily: 'Montserrat'),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Transform.rotate(
                                  angle: -pi / 3,
                                  child: Icon(
                                    Icons.link,
                                    size: 18,
                                    color: Colors.blueAccent[100],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.85,
            left: width * 0.1,
            child: GestureDetector(
              onTap: () {
                // print('click');
                addEventToCal(context);
              },
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              child: Transform.scale(
                scale: _scale,
                child: Container(
                  height: 60,
                  width: width - width * 0.2,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Grey.withOpacity(0.5),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 5))
                    ],
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColorLight
                        ],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.topRight,
                        tileMode: TileMode.repeated),
                  ),
                  child: Center(
                    child: Text(
                      'Add A Reminder',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Add a reminder and we\'ll send you an e-mail an hour before the contest starts.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void addEventToCal(BuildContext context) async {
    if (!hasCalendarPermissions) {
      await _deviceCalendarPlugin.requestPermissions();
      bool newPermissions = (await _deviceCalendarPlugin.hasPermissions()).data;
      setState(() {
        hasCalendarPermissions = newPermissions;
      });
    }

    if (!hasCalendarPermissions) {
      return;
    }

    var retrievedCals = (await _deviceCalendarPlugin.retrieveCalendars()).data;
    List<Map> calendars = [];
    retrievedCals.forEach((cal) {
      Map calObj = {
        'id': cal.id,
        'name': cal.name,
        'account': cal.accountName,
      };

      if (cal.name == cal.accountName) {
        calObj['name'] = "Default";
      }

      calendars.add(calObj);
    });

    var selectedCalendar = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width - 100,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: calendars
                    .map((cal) => Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context, cal);
                            },
                            child: Ink(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 10.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cal['name'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(cal['account']),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );

    if (selectedCalendar == null) {
      return;
    }

    Event event = new Event(selectedCalendar['id']);
    event.title = widget.contestsAPIModel.event;
    event.start =
        DateTime.parse(widget.contestsAPIModel.start.replaceAll('Z', ''));
    event.end = DateTime.parse(widget.contestsAPIModel.end.replaceAll('Z', ''));
    event.eventId = widget.contestsAPIModel.id.toString();
    var newEvent = await _deviceCalendarPlugin.createOrUpdateEvent(event);
    print({
      newEvent.data,
      newEvent.isSuccess,
    });
  }
}
