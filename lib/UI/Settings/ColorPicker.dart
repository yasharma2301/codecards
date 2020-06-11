import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color _mainColor = PopBlue;
  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.brown,
    Colors.yellow,
    Colors.purple,
    PopBlue,
  ];

  @override
  Widget build(BuildContext context) {

    double noOfColors = colors.length % 4 == 0 ? colors.length / 4 : ( colors.length / 4 ).ceilToDouble();
    double height = 55.0 + 95 * noOfColors;

    return Container(
      height: height,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          title: Text("Change Accent Color"),
          backgroundColor: _mainColor,
          centerTitle: true,
          elevation: 0,
        ),
        body: GridView.builder(
            itemCount: colors.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            itemBuilder: (context, index) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        onPressed: () {
                          setState(() {
                            _mainColor = colors[index];
                          });
                        },
                        color: colors[index],
                      ),
                    ),
                    _mainColor == colors[index] ? Icon(Icons.check, color: White,) : Container()
                  ],
                )),
      ),
    );
  }
}
