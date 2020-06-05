import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:codecards/Shared/Colors.dart';
import 'Social.dart';
import 'dart:math' as math;

class SignUpStack extends StatefulWidget {
	@override
	_SignUpStackState createState() => _SignUpStackState();
}

class _SignUpStackState extends State<SignUpStack>
	with SingleTickerProviderStateMixin {
	AnimationController controller;
	Animation moveSocial;
	
	bool _opened = false;
	
	@override
	void initState() {
		super.initState();
		
		controller =
			AnimationController(duration: Duration(seconds: 1), vsync: this);
		
		moveSocial = Tween<double>(begin: 0.0, end: 1.0).animate(
			CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
		
		controller.addListener(() {
			setState(() {
				_opened = controller.isCompleted;
			});
		});
		
		Future.delayed(Duration(milliseconds: 500), () => controller.forward());
	}
	
	@override
	void dispose() {
		controller.dispose();
		super.dispose();
	}
	
	double initPosition = 70;
	
	@override
	Widget build(BuildContext context) {
		return Stack(
			alignment: Alignment.topCenter,
			children: [
				Social(
					opened: _opened,
					moveSocial: moveSocial,
					icon: Icon(FontAwesomeIcons.google, color: White),
					color: Colors.redAccent,
					title: "Login With Google",
					position: initPosition,
				),
				Social(
					opened: _opened,
					moveSocial: moveSocial,
					icon: Icon(FontAwesomeIcons.github, color: White),
					color: Colors.blueGrey[800],
					title: "Login With Github",
					position: initPosition * 2,
				),
				Social(
					opened: _opened,
					moveSocial: moveSocial,
					icon: Icon(FontAwesomeIcons.facebook, color: White),
					color: Colors.blue[300],
					title: "Login With Facebook",
					position: initPosition * 3,
				),
				Container(
					height: 50,
					width: MediaQuery.of(context).size.width,
					child: GestureDetector(
						onTap: () async {
							if(controller.isCompleted) {
                await controller.reverse();
                Navigator.pop(context);
              }
						},
						child: Container(
							padding: EdgeInsets.only(top: 4),
							decoration: BoxDecoration(
								color: PopBlue,
								borderRadius: BorderRadius.only(
									topLeft: Radius.circular(15),
									topRight: Radius.circular(15))),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: [
									SizedBox(
										width: 15,
									),
									RichText(
										text: TextSpan(
											text: "Let's",
											style: TextStyle(
												color: Colors.white.withOpacity(0.9),
												fontSize: 22),
											children: <TextSpan>[
												TextSpan(
													text: " Connect ",
													style: TextStyle(fontWeight: FontWeight.w400)),
												TextSpan(text: "to the Server")
											]),
									),
									Transform.rotate(
										angle: math.pi * moveSocial.value,
										child: Icon(
											Icons.keyboard_arrow_down,
											color: Grey.withOpacity(0.7),
											size: 35,
										),
									)
								],
							),
						),
					)
				),
			],
		);
	}
}
