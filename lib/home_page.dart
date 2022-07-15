import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomo_timer/common/custom_button.dart';
import 'package:google_fonts/google_fonts.dart'; // to be used later stage.

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final String title = "peeeep";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Duration startTime = const Duration(minutes: 25);
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = startTime.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        startTime = Duration(seconds: seconds);
      }
    });
  }

  void _pauseTimer() {
    setState(() {
      countdownTimer!.cancel();
    });
  }

  void _resetTimer() {
    _pauseTimer();
    setState(() {
      startTime = const Duration(minutes: 25);
    });
  }

  void _startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(startTime.inMinutes.remainder(60));
    final seconds = strDigits(startTime.inSeconds.remainder(60));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset("assets/wizardAvatar.png"),
            ),
            Text(
              "$minutes:$seconds",
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: () {
                    _startTimer();
                  },
                  borderRadius: 10,
                  primary: Colors.green,
                  textColor: Colors.white,
                  child: const Text("Start"),
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomButton(
                  onPressed: () {
                    _pauseTimer();
                  },
                  borderRadius: 10,
                  primary: Colors.green,
                  textColor: Colors.white,
                  child: const Text("Pause"),
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomButton(
                  onPressed: () {
                    _resetTimer();
                  },
                  borderRadius: 10,
                  primary: Colors.green,
                  textColor: Colors.white,
                  child: const Text("Reset"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
