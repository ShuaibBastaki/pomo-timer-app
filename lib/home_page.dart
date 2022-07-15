import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomo_timer/common/custom_button.dart';
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
    Image tomatoIMG = Image.asset("assets/tomato.png");
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(startTime.inMinutes.remainder(60));
    final seconds = strDigits(startTime.inSeconds.remainder(60));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController!.view,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController!.value * 2 * pi,
                  child: child,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: tomatoIMG,
              ),
            ),
            Text(
              "$minutes:$seconds",
              style: GoogleFonts.pompiere(
                textStyle: const TextStyle(fontSize: 80),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: () {
                    _startTimer();
                    _rotateTomato(tomatoIMG);
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
                    _stopTomato();
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
                    _resetTomato();
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
