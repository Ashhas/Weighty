import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weighty/bloc/add_weight/add_weight_bloc.dart';

class AddWeightDialog extends StatefulWidget {
  final DateTime selectedDay;

  const AddWeightDialog({this.selectedDay}) : super();

  @override
  _AddWeightDialogState createState() => _AddWeightDialogState();
}

class _AddWeightDialogState extends State<AddWeightDialog> {
  TextEditingController textFormController;

  @override
  void initState() {
    textFormController = TextEditingController();
  }

  @override
  void dispose() {
    textFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  (new DateFormat.yMMMd('en_US')
                      .format(widget.selectedDay)
                      .toString()),
                  style: Theme.of(context).primaryTextTheme.bodyText2,
                )),
            Divider(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Weight",
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  TextFormField(
                    controller: textFormController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      BlocProvider.of<AddWeightBloc>(context).add(
                          AddNewMeasurement(
                              widget.selectedDay, textFormController.text));

                      //Close Dialog
                      Navigator.of(context).pop();
                    },
                  ),
                  RaisedButton(
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      //Close Dialog
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
