import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weighty/bloc/add_weight/add_weight_bloc.dart';
import 'package:weighty/bloc/add_weight/date_button/date_button_bloc.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/ui/add_weight/widgets/add_weight_dialog.dart';
import 'package:weighty/util/common_functions.dart';
import 'package:weighty/util/constants/ui_const.dart';
import 'package:weighty/util/constants/variable_const.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen() : super();

  @override
  _AddWeightScreenState createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  String text = '';
  DateTime chosenDate = kToday;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddWeightBloc>(context).add(AddWeightStarted());
    BlocProvider.of<DateButtonBloc>(context).add(LoadFirstDate());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.11,
              child: Center(
                child: _dateButton(),
              ),
            ),
            _numContainer(),
            _numPadTitleContainer(),
            _numPadKeyboard(),
            _saveButton(),
          ],
        ),
      ),
    );
  }

  // Handle keyboard tap
  _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  // Handle decimal separator tap
  _onDecimalSeparatorTapped() {
    setState(() {
      text = text + UiConst.addWeightDecimalSeparator;
    });
  }

  // Open Calendar widget in dialog
  _openCalender() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddWeightDialog();
      },
    );
  }

  // Date Button
  _dateButton() {
    return ElevatedButton(
      onPressed: () {
        _openCalender();
      },
      child: BlocListener<DateButtonBloc, DateButtonState>(
        listener: (BuildContext context, state) {
          if (state is ShowChosenDate) {
            chosenDate = state.chosenDate;
          }
        },
        child: BlocBuilder<DateButtonBloc, DateButtonState>(
          builder: (context, state) {
            if (state is ShowChosenDate) {
              return Text(
                  "${CommonFunctions.isToday(state.chosenDate) ? UiConst.addWeightDateButtonTodayTitle : DateFormat("EEE").format(state.chosenDate)} | ${DateFormat("dd/MM/yy").format(state.chosenDate)}");
            } else {
              return Container();
            }
          },
        ),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).highlightColor,
        ),
        fixedSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.41,
            MediaQuery.of(context).size.height * 0.066,
          ),
        ),
      ),
    );
  }

  // Container that shows the input from the num pad
  _numContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Center(
        child: BlocBuilder<AddWeightBloc, AddWeightState>(
          builder: (context, state) {
            if (state is AddWeightLoaded) {
              return Text(
                "$text ${state.unitType}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  //NumPad title container
  _numPadTitleContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      child: Center(
        child: Text(
          UiConst.addWeightNumPadTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // NumPad Keyboard
  _numPadKeyboard() {
    return NumericKeyboard(
      onKeyboardTap: _onKeyboardTap,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textColor: Colors.white,
      rightButtonFn: () {
        setState(() {
          text = text.substring(0, text.length - 1);
        });
      },
      rightIcon: Icon(
        Icons.chevron_left,
        color: Colors.white,
      ),
      leftButtonFn: () {
        _onDecimalSeparatorTapped();
      },
      leftIcon: Icon(
        Icons.circle,
        size: 6,
        color: Colors.white,
      ),
    );
  }

  // Save Button
  _saveButton() {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<AddWeightBloc>(context).add(
          AddNewMeasurement(
            chosenDate,
            text,
          ),
        );
      },
      child: Text(UiConst.addWeightSaveLabel),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).highlightColor,
        ),
        fixedSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.41,
            MediaQuery.of(context).size.height * 0.08,
          ),
        ),
      ),
    );
  }
}
