import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'SocialButton.dart';
import 'package:codecards/Shared/Colors.dart';

class Social extends StatefulWidget {
	
	bool opened;
	Animation moveSocial;
	String title;
	Color color;
	Icon icon;
	double position;
	
	Social({ @required this.opened, @required this.moveSocial, @required this.color, @required this.icon, @required this.title, @required this.position});
	
    @override
    _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {
    @override
    Widget build(BuildContext context) {
    return Transform(
	    transform: Matrix4.translationValues(0, widget.position * widget.moveSocial.value, 0),
	    //				                duration: Duration(seconds: 1),
	    child: AnimatedContainer(
		    duration: Duration(seconds: 1),
		    height: 50,
		    width: widget.opened ? 300 : 50,
		    decoration: BoxDecoration(
			    borderRadius: BorderRadius.circular(50)
		    ),
		    curve: Curves.bounceInOut,
		    child: SocialButton(
			    button: widget.opened,
			    title: widget.title,
			    color: widget.color,
			    icon: widget.icon
		    ),
	    )
    );
  }
}
