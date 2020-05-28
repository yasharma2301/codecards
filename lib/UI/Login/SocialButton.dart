import 'package:flutter/material.dart';
import 'package:codecards/Shared/Colors.dart';

class SocialButton extends StatelessWidget {
	
	final String title;
	final Icon icon;
	final Color color;
	final bool button;
	
	SocialButton({this.title, this.icon, this.color, this.button});
	
	@override
	Widget build(BuildContext context) {
		return
			button ?
			RaisedButton(
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(10)
				),
				splashColor: White,
				onPressed: () {
				
				} ,
				color: color,
				child:
				Row(
//					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						icon,
				            SizedBox(width: 10,),
				            Text(title, style: TextStyle(color: White),),
					],
				),
			)
				:
			Container(
				decoration: BoxDecoration(
					borderRadius: BorderRadius.circular(50),
					color: color,
				),
				child: icon,
			);
	}
}