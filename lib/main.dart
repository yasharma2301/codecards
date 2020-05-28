import 'package:flutter/material.dart';
import 'UI/OnBoard/onBoardingScreen.dart';
import 'UI/Login/loginScreen.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
				primarySwatch: Colors.blueGrey,
				visualDensity: VisualDensity.adaptivePlatformDensity,
			),
			initialRoute: '/',
			routes: {
				'/': (context) => OnBoard(),
				'login': (context) => LoginScreen()
			},
		);
	}
}

