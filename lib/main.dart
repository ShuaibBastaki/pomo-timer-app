import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pomo_timer/navigation/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomato Timer',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.green.shade100,
        primarySwatch: Colors.green,
      ),
      home: AnimatedSplashScreen(
        splash: "assets/company_logo.png",
        duration: 1800,
        backgroundColor: const Color.fromARGB(255, 28, 52, 35),
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: const WelcomePage(),
      ),
    );
  }
}
