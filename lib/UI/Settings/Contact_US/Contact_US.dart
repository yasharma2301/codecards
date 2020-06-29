import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ContactUs extends StatefulWidget {
  ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    File _image;
    final picker = ImagePicker();

    Future getImage() async {
      print(_image);
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null)
        setState(() {
          _image = File(pickedFile.path);
        });
      print(_image);
    }

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
                  shape: BoxShape.circle, color: LightGrey.withOpacity(0.4)),
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
                color: LightGrey.withOpacity(0.4),
              ),
            ),
          ),
          SingleChildScrollView(
              padding: EdgeInsets.only(left: 25, right: 25, bottom: 150),
              scrollDirection: Axis.vertical,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'contactUsPage',
                      child: Container(
                        width: width,
                        height: height / 4 + 50,
                        padding: const EdgeInsets.only(top: 50),
                        child: Stack(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Positioned(
                              left: 0,
                              bottom: 10,
                              child: Text(
                                "Contact Us",
                                style: TextStyle(
                                  color: White,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -40,
                              child: Icon(
                                Icons.mail,
                                color: Grey.withOpacity(0.8),
                                size: 250,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: width - 50,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Grey, borderRadius: BorderRadius.circular(6)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: LightGrey.withOpacity(0.7),
                        ),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColorLight,
                          style: TextStyle(fontSize: 20, color: White),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Name",
                              labelStyle: TextStyle(fontSize: 20)),
                          onSubmitted: (text) => print(text),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width - 50,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Grey, borderRadius: BorderRadius.circular(6)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: LightGrey.withOpacity(0.7),
                        ),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColorLight,
                          style: TextStyle(fontSize: 20, color: White),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Email Address",
                              labelStyle: TextStyle(fontSize: 20)),
                          onSubmitted: (text) => print(text),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width - 50,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Grey, borderRadius: BorderRadius.circular(6)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: LightGrey.withOpacity(0.7),
                        ),
                        child: TextField(
                          maxLines: 8,
                          cursorColor: Theme.of(context).primaryColorLight,
                          style: TextStyle(fontSize: 20, color: White),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Describe your problem",
                              labelStyle: TextStyle(fontSize: 20, height: 0.5)),
                          textCapitalization: TextCapitalization.sentences,
                          onSubmitted: (text) => print(text),
                        ),
                      ),
                    ),
                    Divider(
                      height: 50,
                      color: White,
                    ),
                    Text(
                      "Add screenshots to explain your problem (optional) :",
                      style: TextStyle(color: White, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: getImage,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Grey.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10)),
                            child: _image == null
                                ? Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Image.file(_image),
                          ),
                        ),
                        if (_image != null)
                          Container(
                            height: 50,
                            width: 50,
                            color: Red,
                          )
                      ],
                    )
                  ])),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 6.0,
                ),
              ]),
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Ink(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColorLight
                          ],
                          stops: [
                            0.3,
                            0.95
                          ],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.topRight,
                          tileMode: TileMode.repeated),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Text("Send Query",
                        style: TextStyle(
                          color: White,
                          fontSize: 18,
                        )),
                  ),
                ),
              ),
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
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
