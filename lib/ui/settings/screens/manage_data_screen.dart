import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/export/export_bloc.dart';
import 'package:weighty/ui/settings/widgets/settings_tile.dart';

class ManageDataScreen extends StatefulWidget {
  ManageDataScreen();

  @override
  _ManageDataScreenState createState() => _ManageDataScreenState();
}

class _ManageDataScreenState extends State<ManageDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SettingsTile(
              title: "Export Data",
              titleTextStyle: Theme.of(context).primaryTextTheme.bodyText2,
              leading: Icon(
                Icons.file_download,
                color: Colors.grey,
              ),
              onPressed: (BuildContext context) {
                BlocProvider.of<ExportBloc>(context).add(StartExport());
              },
            ),
            Divider(height: 1, thickness: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Theme.of(context).canvasColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Theme.of(context).buttonColor),
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "Manage Data",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
