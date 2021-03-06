import 'package:codecards/Services/Themes/accentColorProvider.dart';
import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/themesEnum.dart';

class AccentColorPicker extends StatefulWidget {
  @override
  _AccentColorPickerState createState() => _AccentColorPickerState();
}

class _AccentColorPickerState extends State<AccentColorPicker> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    ThemeData _mainTheme = themeChanger.getTheme();
    List<ThemeData> _gradients = [];

    appThemeData.forEach((key, value) {
      _gradients.add(value);
    });

    double height =
        _gradients.length <= 6 ? _gradients.length.toDouble() * 85 : 6.0 * 85;

    return Container(
      height: height,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          title: Text("Change Accent Color"),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.check,
            color: White,
          ),
          onPressed: () => Navigator.pop(context),
          backgroundColor: LightGrey,
        ),
        body: ListView.builder(
            padding: EdgeInsets.only(top: 15),
            itemCount: _gradients.length,
            itemBuilder: (context, index) => Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width - 150,
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    stops: [0.3, 0.95],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.topRight,
                                    tileMode: TileMode.repeated,
                                    colors: [
                                      _gradients[index].primaryColor,
                                      _gradients[index].primaryColorLight
                                    ]),
                                // color: _gradients[index],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _mainTheme = _gradients[index];
                                themeChanger.setTheme(_gradients[index]);
                              });
                              // Navigator.pop(context);
                            },
                            // color: _gradients[index],
                          ),
                        ),
                        _mainTheme == _gradients[index]
                            ? Icon(
                                Icons.check,
                                color: White,
                              )
                            : Container()
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                )),
      ),
    );
  }
}
