import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weighty/data/model/measurement.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weighty/data/repo/measurement_repo.dart';
import 'package:weighty/util/shared_pref_service.dart';

class ExportHandler {
  static generateExcel(List<MeasurementModel> allMeasurements,
      MeasurementModel currentWeight, double targetWeight) async {
    final MeasurementRepository measurementRepository =
        new MeasurementRepository();
    MeasurementModel latestMeasurement =
        await measurementRepository.getLatestMeasurement();
    final sharedPrefService = await SharedPreferencesService.instance;
    double targetWeight = sharedPrefService.getTargetWeight;

    //Request access to storage
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    //Create Excel File
    var excel = Excel.createExcel();

    //Read-in the first sheet
    var sheet = excel.sheets.values.first;

    //Excel Template
    sheet.appendRow(["WEIGHTY"]);
    sheet.appendRow(["MEASUREMENTS EXPORT"]);
    sheet.appendRow([""]);
    sheet.appendRow([
      "Print date: ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"
    ]);
    sheet.appendRow(["Current Weight: ${currentWeight.weightEntry} kg"]);
    sheet.appendRow(["Target Weight: ${targetWeight.toString()} kg"]);
    sheet.appendRow([""]);
    sheet.appendRow([""]);
    sheet.appendRow(["Date", "Weight"]);

    //Iterate through measurements and add to sheet
    allMeasurements.forEach((element) {
      sheet.appendRow([
        "${element.dateAdded.year}-${element.dateAdded.month}-${element.dateAdded.day}",
        element.weightEntry
      ]);
    });

    //Formulate filename
    String dir = (await getExternalStorageDirectory()).path +
        "/measurements-${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}--${DateTime.now().minute}.${DateTime.now().second}.xlsx";

    //Save Excel to internal storage
    var fileBytes = excel.save();

    File(join(dir))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
  }
}
