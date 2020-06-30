import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Try extends StatefulWidget {
  @override
  _TryState createState() => _TryState();
}

class _TryState extends State<Try> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        centerTitle: true,
      ),
      body: Center(
        child: _image == null
            ? RaisedButton(
                onPressed: getImage,
                child: Text("Choose Picture"),
              )
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(_image);
        },
      ),
    );
  }
}
