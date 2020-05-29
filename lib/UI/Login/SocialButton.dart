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
			button
				?
					GestureDetector(
						onTap: (){
							Scaffold.of(context).showSnackBar(SnackBar(
								content: Text(title),
								action: SnackBarAction(
									label: 'UNDO', onPressed: () => Scaffold.of(context).hideCurrentSnackBar()),
							));
						},
						child: Container(
							padding: EdgeInsets.symmetric(horizontal: 10),
							decoration: BoxDecoration(
								color: color,
								borderRadius: BorderRadius.circular(10)
							),
							child: Row(
								children: [
									icon,
									Flexible(
										flex: 1,
										child: FractionallySizedBox(
											child: Container(
												margin: EdgeInsets.symmetric(horizontal: 15),
												child: Text(
													title,
													style: TextStyle(
														color: White,
														fontSize: 17
													),
												),
											)
										),
									)
								],
							),
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