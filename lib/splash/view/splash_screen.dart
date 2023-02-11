import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/home/controller/home_controller.dart';

import 'package:weather_app/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getIp();
      provider.getCurrentLocation();
      Provider.of<SplashController>(context, listen: false).goToHome(context);
      provider.history();
    });
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'Lilac\nFlutter Assignment',
              textStyle: const TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              colors: [
                Colors.white,
                Colors.purple,
              ],
            ),
            // TypewriterAnimatedText(
            //   'Lilac\nFlutter Assignment',
            //   textStyle: const TextStyle(
            //     fontSize: 32.0,
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   // textAlign: TextAlign.center,
            //   speed: const Duration(
            //     milliseconds: 100,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
