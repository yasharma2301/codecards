import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/delayed_animation.dart';
import 'package:codecards/Shared/FlushBar.dart';

class ContactUs extends StatefulWidget {
  ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs>
    with SingleTickerProviderStateMixin {
  File _image;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  bool checkText() {
    if (nameController.text != '' &&
        emailController.text != '' &&
        descriptionController.text != '') {
      return true;
    } else {
      return false;
    }
  }

  double _showSnackBar = 0;
  AnimationController controller;
  Animation moveSocial;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    moveSocial = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));

    controller.addListener(() {
      setState(() {
        _showSnackBar = controller.value;
      });
      if (controller.isCompleted) {
        Future.delayed(Duration(seconds: 3))
            .then((value) => controller.reverse());
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    FlushBar flushBar = FlushBar(context: context);

    final picker = ImagePicker();

    Future _getImage() async {
      var image = await picker.getImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    }

    return Scaffold(
      key: _scaffoldKey,
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
            padding: EdgeInsets.only(
                left: 25, right: 25, bottom: checkText() ? 80 : 0),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'contactUsPage',
                  child: Container(
                    width: width,
                    height: height / 4.5,
                    padding: const EdgeInsets.only(top: 30),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 10,
                          child: Material(
                            child: Text(
                              "Support".toUpperCase(),
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
                ),
                SizedBox(
                  height: 10,
                ),
                DelayedAnimation(
                  delay: 50,
                  child: Column(
                    children: [
                      Container(
                        width: width - 50,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Grey,
                            borderRadius: BorderRadius.circular(6)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: LightGrey.withOpacity(0.7),
                          ),
                          child: TextFormField(
                            controller: nameController,
                            cursorColor: Theme.of(context).primaryColorLight,
                            style: TextStyle(
                              color: White.withOpacity(0.9),
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Enter your name",
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          width: width - 50,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Grey,
                              borderRadius: BorderRadius.circular(6)),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: LightGrey.withOpacity(0.7),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              cursorColor: Theme.of(context).primaryColorLight,
                              style: TextStyle(
                                color: White.withOpacity(0.9),
                                fontSize: 20,
                              ),
                              validator: (value) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                return (!regex.hasMatch(value)) ? '' : null;
                              },
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(height: 0),
                                  border: InputBorder.none,
                                  labelText: "Email Address",
                                  labelStyle: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: 18,
                                      height: 1)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: width - 50,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Grey,
                            borderRadius: BorderRadius.circular(6)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: LightGrey.withOpacity(0.7),
                          ),
                          child: TextFormField(
                            controller: descriptionController,
                            maxLines: 8,
                            cursorColor: Theme.of(context).primaryColorLight,
                            style: TextStyle(
                                fontSize: 18, color: White.withOpacity(0.9)),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Describe your problem",
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    height: 0.5,
                                    color:
                                        Theme.of(context).primaryColorLight)),
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DelayedAnimation(
                  delay: 400,
                  child: Column(
                    children: [
                      Divider(
                        height: 50,
                        color: White,
                        thickness: 0.3,
                      ),
                      Text(
                        "Add a screenshot (optional) :",
                        style: TextStyle(
                            color: White,
                            fontSize: 17,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: _getImage,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 180,
                              width: 150,
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
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                )
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
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: checkText() == true ? 1 : 0,
              child: Material(
                child: InkWell(
                  splashColor: Theme.of(context).primaryColorLight,
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      Map response = await _sendQuery();
                      if (response['success']) {
                        Navigator.pop(context, response);

                        flushBar.showSuccessFlushBar(
                          "Your query has been recorded and our team will contact you soon. Thank you.",
                        );
                      } else {
                        flushBar.showErrorFlushBar(
                          response['message'],
                        );
                      }
                    } else {
                      flushBar.showErrorFlushBar(
                        "Please enter a valid Email Address!",
                      );
                    }
                  },
                  child: Ink(
                    height: 50,
                    width: width,
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
                    ),
                    child: Center(
                        child: Text(
                      'Send Query',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w300,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.scale(
              scale: _showSnackBar,
              child: Container(
                // duration: Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: 20),
                width: width - 20,
                height: 45,
                decoration: BoxDecoration(
                    color: Color(0xFF333333),
                    border: Border(
                        left: BorderSide(color: Colors.redAccent, width: 2.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Please Enter a Valid Email Address!",
                        style: TextStyle(color: White, fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.reverse();
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.redAccent,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map> _sendQuery() async {
    String url = 'http://192.168.0.105:8000/contact-us/';

    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['name'] = nameController.text
      ..fields['email'] = emailController.text
      ..fields['details'] = descriptionController.text;

    if (_image != null) {
      String screenshotName = _image.path.split('/').last;
      request.files.add(http.MultipartFile(
          'screenshot', _image.readAsBytes().asStream(), _image.lengthSync(),
          filename: screenshotName));
    } else
      request.fields['screenshot'] = '';
    var response = await request.send();
    if (response.statusCode == 200) {
      return {
        'success': true,
        'message':
            "Query Successfully sent to our Support team. We will try to respond to you as soon as we can."
      };
    } else {
      return {
        'success': false,
        'message': "Server Error! Please try again later."
      };
    }
  }
}
