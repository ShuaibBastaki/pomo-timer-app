// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomo_timer/design/clicky_button.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final String title = "Pomo";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  bool isButtonActive = true;
  Duration startTime = const Duration(minutes: 25);
  Timer? countdownTimer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    super.initState();
  }

  void setCountDown() {
    const reduceSecondsBy = 1;

    setState(() {
      final seconds = startTime.inSeconds - reduceSecondsBy;

      if (seconds < 0) {
        countdownTimer!.cancel();
        _resetTomato();
        _startBreakTimer();
        countdownTimer!.cancel();
        _resetTomato();
      } else {
        startTime = Duration(seconds: seconds);
      }
    });
  }

  void _startBreakTimer() {
    setState(() {
      startTime = const Duration(minutes: 5);
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
    setState(() {
      countdownTimer =
          Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    });
  }

  void _rotateTomato(Image image) {
    setState(() {
      _animationController!.repeat();
    });
  }

  void _resetTomato() {
    _animationController!.reset();
  }

  void _stopTomato() {
    _animationController!.stop();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Image tomatoIMG = Image.asset("assets/Tomato_Pixelated.png");
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(startTime.inMinutes.remainder(60));
    final seconds = strDigits(startTime.inSeconds.remainder(60));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              child: AnimatedBuilder(
                animation: _animationController!.view,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animationController!.value * 2 * pi,
                    child: child,
                  );
                },
                child: tomatoIMG,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "$minutes:$seconds",
              style: GoogleFonts.sedgwickAve(
                fontSize: 88,
                textStyle: TextStyle(
                  fontSize: 80,
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 340,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClickyButton(
                      onPressed: isButtonActive
                          ? () {
                              setState(() {
                                _startTimer();
                                _rotateTomato(tomatoIMG);
                                isButtonActive = false;
                              });
                            }
                          : (() {}),
                      color: Colors.green,
                      child: Text(
                        "start",
                        style: GoogleFonts.josefinSans(
                          textStyle: const TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ClickyButton(
                      onPressed: () {
                        _pauseTimer();
                        _stopTomato();
                        isButtonActive = true;
                      },
                      color: Colors.lime,
                      child: Text(
                        "pause",
                        style: GoogleFonts.josefinSans(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            ),
            ClickyButton(
              onPressed: () {
                _resetTimer();
                _resetTomato();
                isButtonActive = true;
              },
              color: Colors.red,
              child: Text(
                "reset",
                style: GoogleFonts.josefinSans(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
