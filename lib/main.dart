import 'package:codecards/UI/MainNavigationUI/MenuDashboardLayout/menu_dashboard.dart';
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
			title: 'Code Cards',
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
				primarySwatch: Colors.blueGrey,
				visualDensity: VisualDensity.adaptivePlatformDensity,
			),
			initialRoute: '/',
			routes: {
				'/': (context) => OnBoard(),
				'login': (context) => LoginScreen(),
				'menuDashBoard': (context) => MenuDashboardPage()
			},
		);
	}
}

