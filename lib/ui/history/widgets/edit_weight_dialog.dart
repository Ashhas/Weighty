import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/history/history_bloc.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/constants/ui_const.dart';

class EditWeightDialog extends StatefulWidget {
  final MeasurementModel selectedMeasurement;

  const EditWeightDialog({this.selectedMeasurement}) : super();

  @override
  _EditWeightDialogState createState() => _EditWeightDialogState();
}

class _EditWeightDialogState extends State<EditWeightDialog> {
  TextEditingController textFormController;

  @override
  void initState() {
    super.initState();
    textFormController = TextEditingController();
    textFormController.text = widget.selectedMeasurement.weightEntry.toString();
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
                    UiConst.editWeightDialogTitle,
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
                  RaisedButton(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    color: Theme.of(context).canvasColor,
                    onPressed: () {
                      BlocProvider.of<HistoryBloc>(context).add(
                        EditMeasurement(
                          widget.selectedMeasurement,
                          textFormController.text,
                        ),
                      );

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
