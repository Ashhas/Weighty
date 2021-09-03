import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/settings/goals/goals_bloc.dart';

class EditTargetWeightDialog extends StatefulWidget {
  final double targetWeight;

  const EditTargetWeightDialog({this.targetWeight}) : super();

  @override
  _EditTargetWeightDialogState createState() => _EditTargetWeightDialogState();
}

class _EditTargetWeightDialogState extends State<EditTargetWeightDialog> {
  final textFormController = TextEditingController();

  @override
  void initState() {
    textFormController.text = widget.targetWeight.toString();
    super.initState();
  }

  @override
  void dispose() {
    textFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
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
                    "Target Weight",
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  TextFormField(
                    controller: textFormController,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).primaryTextTheme.subtitle1,
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
                    color: Theme.of(context).highlightColor,
                    onPressed: () {
                      BlocProvider.of<GoalsBloc>(context).add(
                          ChangeTargetWeight(
                              targetWeight: textFormController.text));

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
