import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weighty/ui/on_boarding/on_boarding_goal_screen.dart';
import 'package:weighty/ui/on_boarding/on_boarding_start_weight_screen.dart';

class OnBoardingEntryScreen extends StatefulWidget {
  @override
  _OnBoardingEntryScreenState createState() => _OnBoardingEntryScreenState();
}

class _OnBoardingEntryScreenState extends State<OnBoardingEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.2,
                        width: MediaQuery.of(context).size.height * 0.2,
                        child: Image(
                          image: AssetImage(
                            "assets/weight-icon.jpg",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Weighty",
                        style: GoogleFonts.roboto(
                            fontSize: 30.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120.0,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        "Your personal weight tracker and management app!",
                        style: GoogleFonts.roboto(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                alignment: AlignmentDirectional.bottomCenter,
                margin: EdgeInsets.only(bottom: 20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 350, height: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnBoardingStartScreen()),
                      );
                    },
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.roboto(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      onPrimary: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}