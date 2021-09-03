import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/app_init/initialization_bloc.dart';
import 'package:weighty/bloc/on_boarding/on_boarding_bloc.dart';
import 'package:weighty/ui/bottom_nav_bar.dart';

class OnBoardingGoalScreen extends StatefulWidget {
  @override
  _OnBoardingGoalScreenState createState() => _OnBoardingGoalScreenState();
}

class _OnBoardingGoalScreenState extends State<OnBoardingGoalScreen> {
  final TextEditingController targetWeightController = TextEditingController();

  //Feedback Variables
  bool onlyNumbers = true;
  bool filledIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: BlocListener<OnBoardingBloc, OnBoardingState>(
        listener: (context, onBoardingState) {
          if (onBoardingState is OnBoardingFinished) {
            BlocProvider.of<InitializationBloc>(context)
                .add(FinishOnBoarding());
            Navigator.pushAndRemoveUntil(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) => new BottomNavBar(),
                ),
                (Route<dynamic> route) => false);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Center(
                child: Text(
                  "Input your weight information to get started",
                  style: Theme.of(context).primaryTextTheme.bodyText2,
                ),
              ),
              SizedBox(
                height: 70,
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Goal Weight",
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  SizedBox(height: 5),
                  _feedbackMessageWidgets(),
                  SizedBox(height: 5),
                  TextField(
                    controller: targetWeightController,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              AspectRatio(
                aspectRatio: 20 / 3,
                child: ElevatedButton(
                  onPressed: () {
                    if (targetWeightController.text.isNotEmpty) {
                      if (num.tryParse(targetWeightController.text) != null) {
                        //Add Start Weight
                        BlocProvider.of<OnBoardingBloc>(context).add(
                            AddedWeightGoal(
                                targetWeight: targetWeightController.text));
                      } else {
                        _showOnlyNumbersMessage();
                      }
                    } else {
                      _showNotFilledInMessage();
                    }
                  },
                  child: Text(
                    "Finish",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                    onPrimary: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      )),
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
