import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/delayed_animation.dart';

class Avatar extends StatefulWidget {
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  final List<String> _listItems = [
    'assets/images/boss.PNG',
    'assets/images/amie.PNG',
    'assets/images/astro.PNG',
    'assets/images/rj.PNG',
    'assets/images/boy.PNG',
    'assets/images/uncle2.PNG',
    'assets/images/jsutin.PNG',
    'assets/images/brenda.PNG',
    'assets/images/nadie.PNG',
    'assets/images/uncle.PNG',
  ];

  @override
  Widget build(BuildContext context) {
    UserRepository _userProvider = Provider.of<UserRepository>(context);
    String _selected = _userProvider.getUserAvatar();

    return Scaffold(
      backgroundColor: Grey,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: 'avatarHero',
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage('assets/images/avatar.PNG'),
                              fit: BoxFit.cover)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                                  Colors.black.withOpacity(.5),
                                  Colors.black.withOpacity(.1),
                                ])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: Text(
                                "Select an Avatar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: DelayedAnimation(
                    delay: 50,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: _listItems
                          .map((item) => GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      _selected = item;
                                      _userProvider.setUserAvatar(
                                          _selected, null,
                                          update: true);
                                    },
                                  );
                                },
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: AssetImage(item),
                                            fit: BoxFit.cover)),
                                    child: Opacity(
                                      opacity: _selected == item ? 1 : 0,
                                      child: Transform.translate(
                                        offset: Offset(60, -60),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 68, vertical: 67),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey[300]),
                                          child: Icon(
                                            Icons.check,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  )),
                ],
              ),
            ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                      child: Text("Confirm Avatar",
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
              top: 15,
              child: DelayedAnimation(
                delay: 10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(10)),
                    color: Grey,
                  ),
                  child: Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(10)),
                      color: LightGrey.withOpacity(0.55),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
