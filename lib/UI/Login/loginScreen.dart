import 'package:codecards/UI/Login/SignUpStack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codecards/Shared/Colors.dart';
import 'SignUpStack.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
	
	double screenHeight;
	
    @override
    Widget build(BuildContext context) {
	    screenHeight = MediaQuery.of(context).size.height;
		return Scaffold(
		    backgroundColor: Grey,
		    body: SafeArea(
		        child: Column(
			        mainAxisAlignment: MainAxisAlignment.spaceAround,
			        crossAxisAlignment: CrossAxisAlignment.stretch,
		            children: [
		            	Container(
				            height: screenHeight * 0.4,
				            child: Center(
				              child: Container(
					              height: 300,
					              width: 400,
					              child: SvgPicture.asset("assets/loginPage.svg")
				              ),
				            ),
			            ),
		                Expanded(
		                  child: Container(
			                  padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
			                  decoration: BoxDecoration(
				                  color: Colors.white70.withOpacity(0.4),
				                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
			                  ),
			                  height: screenHeight * 0.4,
			                  child: SignUpStack()
		                  ),
		                ),
		            ],
		        ),
		    ),
		);
    }
}