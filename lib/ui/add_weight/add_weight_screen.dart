import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weighty/bloc/add_weight/add_weight_bloc.dart';
import 'package:weighty/bloc/add_weight/date_button/date_button_bloc.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/ui/add_weight/widgets/add_weight_dialog.dart';
import 'package:weighty/util/constants/ui_const.dart';
import 'package:weighty/util/constants/variable_const.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen() : super();

  @override
  _AddWeightScreenState createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  String text = '';

  // Color screenColor = Color(0xFF435094);
  Color screenColor = Color(0xFF3F51B6);
  Color buttonColor = Colors.black.withOpacity(0.2);
  DateTime chosenDate = DateTime.now();

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
        backgroundColor: screenColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.11,
              child: Center(
                child: ElevatedButton(
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
                              "${isToday(state.chosenDate) ? "Today" : DateFormat("EEE").format(state.chosenDate)} | ${DateFormat("dd/MM/yy").format(state.chosenDate)}");
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
                      buttonColor,
                    ),
                    fixedSize: MaterialStateProperty.all(
                      Size(
                        MediaQuery.of(context).size.width * 0.41,
                        MediaQuery.of(context).size.height * 0.066,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Center(
                child: Text(
                  "$text KG",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              child: Center(
                child: Text(
                  "Enter New Weight Measurement",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              color: screenColor,
              child: NumericKeyboard(
                onKeyboardTap: _onKeyboardTap,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textColor: Colors.white,
                rightButtonFn: () {
                  setState(() {
                    text = text.substring(0, text.length - 1);
                  });
                },
                rightIcon: Icon(
                  Icons.backspace,
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
              ),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AddWeightBloc>(context).add(
                  AddNewMeasurement(
                    chosenDate,
                    text,
                  ),
                );
              },
              child: Text("Save"),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  buttonColor,
                ),
                fixedSize: MaterialStateProperty.all(
                  Size(
                    MediaQuery.of(context).size.width * 0.41,
                    MediaQuery.of(context).size.height * 0.08,
                  ),
                ),
              ),
            ),
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
      text = text + ",";
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

  bool isToday(DateTime dateToCheck) {
    return DateTime.now().year == dateToCheck.year &&
        DateTime.now().month == dateToCheck.month &&
        DateTime.now().day == dateToCheck.day;
  }
}
