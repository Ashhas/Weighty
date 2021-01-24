import 'package:weighty/data/model/measurement.dart';
import 'package:weighty/util/strings.dart';
import 'package:weighty/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppThemes.backgroundColor,
        title: Text(
          GlobalStrings.historyTitle,
          style: AppThemes.screenTitleTxtStyle,
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('weightInfo').listenable(),
        builder: (context, box, widget) {
          if (box.values.isEmpty)
            return Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: ListTile(
                    title: Text("sda"),
                    enabled: true,
                    tileColor: Color.fromRGBO(28, 42, 53, 1.0)));

          return ListView.builder(
            shrinkWrap: true,
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              MeasurementModel measurement = box.getAt(index);
              return Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: ListTile(
                  leading: Text(measurement.dateAdded.toString()),
                  title: Text(measurement.weightEntry.toString()),
                  dense: true,
                  trailing: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right_outlined),
                    iconSize: 25,
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
