import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
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
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    return Scaffold(
      backgroundColor: darkTheme.getMode() == true ? Grey : White,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                // left: 20,
                // right: 20,
                top: 10,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Hero(
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
                                    darkTheme.getMode() == true
                                        ? Colors.black.withOpacity(.5)
                                        : White.withOpacity(0.1),
                                    darkTheme.getMode() == true
                                        ? Colors.black.withOpacity(.1)
                                        : Black.withOpacity(0.01),
                                  ])),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Material(
                                color: Colors.transparent,
                                child: Text(
                                  "Select an Avatar",
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                          offset: Offset(1.0, 1.5),
                                          blurRadius: 5.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ],
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Ink(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
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
                          child: Text("Confirm Avatar",
                              style: TextStyle(
                                color: White,
                                fontSize: 20.0,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Material(
              elevation: 30,
              child: Positioned(
                left: 0,
                top: 15,
                child: DelayedAnimation(
                  delay: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(10)),
                      color: darkTheme.getMode() == true ? Grey : White,
                    ),
                    child: Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(10)),
                        color: darkTheme.getMode() == true
                            ? LightGrey.withOpacity(0.55)
                            : White,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.keyboard_backspace,
                          color:
                              darkTheme.getMode() == true ? Colors.white : Grey,
                        ),
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
