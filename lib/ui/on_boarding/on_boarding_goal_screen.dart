import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/app_init/initialization_bloc.dart';
import 'package:weighty/bloc/on_boarding/on_boarding_bloc.dart';
import 'package:weighty/ui/bottom_nav_bar.dart';
import 'package:weighty/util/constants/ui_const.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Text(
                UiConst.targetSummaryTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                UiConst.targetSummarySubtitle,
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
              SizedBox(height: 40),
              AspectRatio(
                aspectRatio: 20 / 2.4,
                child: ElevatedButton(
                  onPressed: () {
                    if (targetWeightController.text.isNotEmpty) {
                      //Add Start Weight
                      BlocProvider.of<OnBoardingBloc>(context).add(
                          AddedWeightGoal(
                              targetWeight: targetWeightController.text));
                    } else {
                      _showNotFilledInMessage();
                    }
                  },
                  child: Text(
                    UiConst.targetButtonTitle,
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
                  UiConst.incompleteInputError,
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
}
