import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weighty/bloc/on_boarding/on_boarding_bloc.dart';
import 'package:weighty/ui/on_boarding/on_boarding_start_weight_screen.dart';

class OnBoardingUnitScreen extends StatefulWidget {
  @override
  _OnBoardingUnitScreenState createState() => _OnBoardingUnitScreenState();
}

class _OnBoardingUnitScreenState extends State<OnBoardingUnitScreen> {
  final TextEditingController startWeightController = TextEditingController();

  //Feedback Variables
  bool onlyNumbers = true;
  bool filledIn = true;
  String _chosenValue;

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Choose your weight unit",
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  SizedBox(height: 5),
                  _feedbackMessageWidgets(),
                  SizedBox(height: 5),
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    dropdownColor: Colors.white,
                    value: _chosenValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'KG',
                      'LB',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "--",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 70),
              AspectRatio(
                aspectRatio: 20 / 3,
                child: ElevatedButton(
                  onPressed: () {
                    if (_chosenValue != null) {
                      //Add Start Weight
                      BlocProvider.of<OnBoardingBloc>(context)
                          .add(AddedWeightUnit(weightUnit: _chosenValue));

                      //Navigate to Goal Screen
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftJoined,
                          child: OnBoardingStartScreen(),
                          childCurrent: context.widget,
                        ),
                      );
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
