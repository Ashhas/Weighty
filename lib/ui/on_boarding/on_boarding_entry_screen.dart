import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weighty/ui/on_boarding/on_boarding_weight_unit_screen.dart';

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
                    height: 90.0,
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.25,
                        width: MediaQuery.of(context).size.height * 0.25,
                        child: Image(
                          image: AssetImage(
                            "assets/weighty_logo_lightblue.png",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                      Text(
                        "Weighty",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        "Your personal weight tracker and management app!",
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                alignment: AlignmentDirectional.bottomCenter,
                margin: EdgeInsets.only(bottom: 35.0),
                child: AspectRatio(
                  aspectRatio: 20 / 2.4,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftJoined,
                          child: OnBoardingUnitScreen(),
                          childCurrent: context.widget,
                        ),
                      );
                    },
                    child: Text(
                      "Get Started",
                      style: Theme.of(context).primaryTextTheme.subtitle1,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
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
