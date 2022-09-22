// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomo_timer/design/clicky_button.dart';
import 'package:pomo_timer/design/frosted_card.dart';
import 'package:pomo_timer/navigation/home_page.dart';
import 'package:video_player/video_player.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late VideoPlayerController _videoController =
      VideoPlayerController as VideoPlayerController;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/tomato.mp4")
      ..initialize().then((_) {
        setState(() {});
      });
    _videoController.setLooping(true);
    _videoController.play();
    _videoController.setVolume(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          VideoPlayer(_videoController),
          Center(
            child: FrostedCard(
              theHeight: 320.0,
              theWidth: 380.0,
              theChild: Padding(
                padding: EdgeInsets.all(18),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: GoogleFonts.signika(
                              textStyle: TextStyle(
                                  fontSize: 40,
                                  color: Colors.lightGreen.shade200),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Prepare ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: "your ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: "mind to ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: "focus",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.yellow),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: ClickyButton(
                                      child: Text(
                                        "I'm ready",
                                        style: GoogleFonts.dosis(
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      color: Colors.teal,
                                      onPressed: () async {
                                        Future.delayed(
                                            Duration(milliseconds: 1600), () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()),
                                          );
                                        });
                                      }),
                                ),
                                SizedBox(
                                  height: 100,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 30, right: 20),
                                    child: Image.asset("assets/white_dog.gif"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
    _textController.dispose();
  }
}
