import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weighty/bloc/on_boarding/on_boarding_bloc.dart';
import 'package:weighty/ui/on_boarding/on_boarding_goal_screen.dart';

class OnBoardingStartScreen extends StatefulWidget {
  @override
  _OnBoardingStartScreenState createState() => _OnBoardingStartScreenState();
}

class _OnBoardingStartScreenState extends State<OnBoardingStartScreen> {
  final TextEditingController startWeightController = TextEditingController();

  //Feedback Variables
  bool onlyNumbers = true;
  bool filledIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Text(
                "Enter your current weight",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Enter the weight your starting with",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 35),
              _feedbackMessageWidgets(),
              SizedBox(height: 5),
              TextField(
                controller: startWeightController,
                keyboardType: TextInputType.number,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
              SizedBox(height: 40),
              AspectRatio(
                aspectRatio: 20 / 2.4,
                child: ElevatedButton(
                  onPressed: () {
                    if (startWeightController.text.isNotEmpty) {
                      if (num.tryParse(startWeightController.text) != null) {
                        //Add Start Weight
                        BlocProvider.of<OnBoardingBloc>(context).add(
                            AddedStartWeight(
                                startWeight: startWeightController.text));

                        //Navigate to Goal Screen
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            child: OnBoardingGoalScreen(),
                            childCurrent: context.widget,
                          ),
                        );
                      } else {
                        _showOnlyNumbersMessage();
                      }
                    } else {
                      _showNotFilledInMessage();
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
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
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  _feedbackMessageWidgets() {
    return Column(
      children: [
        Visibility(
          visible: !filledIn,
          child: Column(
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Not everything has been filled in",
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: !onlyNumbers,
          child: Column(
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Only Numbers!",
                  style: Theme.of(context).primaryTextTheme.subtitle2,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _showNotFilledInMessage() {
    setState(() {
      filledIn = false;
    });

    Future.delayed(Duration(seconds: 6)).then((value) => {
          setState(() {
            filledIn = true;
          })
        });
  }

  _showOnlyNumbersMessage() {
    setState(() {
      onlyNumbers = false;
    });

    Future.delayed(Duration(seconds: 6)).then((value) => {
          setState(() {
            onlyNumbers = true;
          })
        });
  }
}
