import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
		return Scaffold(
		  backgroundColor: Grey,
		    body: SafeArea(
		        child: Center(
		            child:
		            Row(
//			            alignment: Alignment.center,
		                children: [
		                    Container(
				                height: 50,
				                width: 300,
				                margin: EdgeInsets.fromLTRB(0, 0, 0, 200),
				                child: ClipRRect(
		                            borderRadius: BorderRadius.all(Radius.circular(50)),
		                            child: RaisedButton(
		                                splashColor: Grey,
		                                onPressed: () {},
		                                child: Text(
		                                    'Sign Up',
		                                    style: TextStyle(
		                                        fontSize: 24, color: Grey, fontWeight: FontWeight.w400),
		                                ),
		                            ),
		                        ),
		                    ),
			                Container(
				                color: White,
			                    child: Column(
				                    children: [
				                    	IconButton(
						                    onPressed: () {} ,
						                    icon: FaIcon(FontAwesomeIcons.facebook),
					                    )
				                    ],
			                    ),
			                ),
		                ],
		            ),
		        ),
		    ),
		);
    }
}
