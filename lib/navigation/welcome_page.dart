// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomo_timer/design/clicky_button.dart';
import 'package:pomo_timer/navigation/home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style:
                    TextStyle(fontSize: 30, color: Colors.lightGreen.shade800),
                children: <TextSpan>[
                  TextSpan(
                    text: "How ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: "many ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: "pomodoro ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade600),
                  ),
                  TextSpan(
                    text: "cycles?",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter break cycles here',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(
              height: 80,
            ),
            Transform.scale(
              scale: 0.8,
              child: ClickyButton(
                  child: Text(
                    "I'm ready",
                    style: GoogleFonts.dosis(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  color: Colors.teal,
                  onPressed: () async {
                    Future.delayed(Duration(milliseconds: 1600), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
