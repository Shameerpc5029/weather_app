import 'package:flutter/material.dart';
import 'package:weather_app/home/view/home_screen.dart';

class SplashController extends ChangeNotifier {
 Future< void> goToHome(context) async {
    await Future.delayed(
      const Duration(seconds: 3),
    ).then(
      (value) => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      ),
    );
  }
}
