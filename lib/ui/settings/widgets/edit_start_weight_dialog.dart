import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/settings/goals/goals_bloc.dart';

class EditStartWeightDialog extends StatefulWidget {
  final double startWeight;

  const EditStartWeightDialog({this.startWeight}) : super();

  @override
  _EditStartWeightDialogState createState() => _EditStartWeightDialogState();
}

class _EditStartWeightDialogState extends State<EditStartWeightDialog> {
  final textFormController = TextEditingController();

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
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Start Weight",
                    style: Theme.of(context).textTheme.subtitle1,
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
                      BlocProvider.of<GoalsBloc>(context).add(ChangeStartWeight(
                          startWeight: textFormController.text));

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