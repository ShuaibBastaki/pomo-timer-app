import 'package:flutter/material.dart';
import 'package:pomo_timer/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro Timer',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.green.shade100,
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}
