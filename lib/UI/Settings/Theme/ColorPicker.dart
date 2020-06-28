import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:codecards/Shared/themes.dart';
import 'package:provider/provider.dart';

class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  // List<List<Color>> _gradients = [
  //   [Color(0xFF654ea3), Color(0xFFeaafc8)],
  //   [PopBlue, Colors.blueAccent[100]],
  //   [Color(0xFFffa77b), Color(0xFFff5e62)],
  //   [Color(0xFFfeb47b), Color(0xFFff7e5f)],
  //   [Color(0xFFd4fc79), Color(0xFF96e6a1)],
  //   [Color(0xFF84fab0), Color(0xFF8fd3f4)],
  //   [Color(0xFF9890e3), Color(0xFFb1f4cf)],
  //   [Color(0xFF74ebd5), Color(0xFF9face6)],
  //   [Color(0xFF9795f0), Color(0xFFfbc8d4)],
  //   [Color(0xFFabecd6), Color(0xFFfbed96)],
  // ];

  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);

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
          // backgroundColor: _mainTheme,
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
                            // shape: RoundedRectangleBorder(
                            // borderRadius: BorderRadius.circular(100)),
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
