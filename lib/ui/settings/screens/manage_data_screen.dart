import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/export/export_bloc.dart';
import 'package:weighty/ui/common/common_app_bar.dart';
import 'package:weighty/ui/settings/widgets/settings_tile.dart';
import 'package:weighty/util/constants/ui_const.dart';

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
      appBar: CommonAppBar(appBarTitle: UiConst.manageDataScreenTitle),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SettingsTile(
              title: UiConst.exportDataTileTitle,
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
}
