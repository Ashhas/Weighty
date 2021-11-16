import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/settings/goals/goals_bloc.dart';
import 'package:weighty/util/constants/ui_const.dart';

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
                    UiConst.goalWeightDialogTitle,
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  TextFormField(
                    controller: textFormController,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).canvasColor),
                    ),
                    onPressed: () {
                      BlocProvider.of<GoalsBloc>(context).add(
                          ChangeTargetWeight(
                              targetWeight: textFormController.text));

                      //Close Dialog
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
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
