import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/data/model/measurement.dart';

class SmallWeightChartWidget extends StatefulWidget {
  SmallWeightChartWidget() : super();

  @override
  _SmallWeightChartWidgetState createState() => _SmallWeightChartWidgetState();
}

class _SmallWeightChartWidgetState extends State<SmallWeightChartWidget> {
  List<Color> colors = [Colors.lightGreen];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoaded) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 5),
              child: Column(
                children: [
                  Container(
                      child: AspectRatio(
                          aspectRatio: 1.70,
                          child: LineChart(
                            mainData(state.startWeight, state.targetWeight,
                                state.filteredMeasurements),
                            swapAnimationDuration: Duration(milliseconds: 150),
                            swapAnimationCurve: Curves.linear, // Optional
                          ))),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  LineChartData mainData(double startWeight, double targetWeight,
      List<MeasurementModel> filteredList) {
    var hz = [
      HorizontalLine(
          color: Colors.red,
          y: startWeight,
          label: HorizontalLineLabel(
            show: true,
          )),
      HorizontalLine(
        color: Colors.lightGreen,
        y: targetWeight,
        label: HorizontalLineLabel(
          show: true,
        ),
      ),
    ];

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        horizontalInterval: 5,
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(
          showTitles: false,
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'JAN';
              case 2:
                return 'FEB';
              case 3:
                return 'MRT';
              case 4:
                return 'APR';
              case 5:
                return 'MAY';
              case 6:
                return 'JUN';
              case 7:
                return 'JUL';
              case 8:
                return 'AUG';
              case 9:
                return 'SEP';
              case 10:
                return 'OCT';
              case 11:
                return 'NOV';
              case 12:
                return 'DEC';
            }
            return '';
          },
          margin: 10,
        ),
      ),
      minX: filteredList.first.dateAdded.month.toDouble(),
      maxX: (filteredList.last.dateAdded.month.toDouble() +
          ((filteredList.last.dateAdded.day) / 31)),
      minY: targetWeight,
      maxY: startWeight + 10,
      lineBarsData: [
        LineChartBarData(
          spots: filteredList
              .map((element) => FlSpot(
                  element.dateAdded.month.toDouble() +
                      ((element.dateAdded.day) / 31),
                  element.weightEntry))
              .toList(),
          isCurved: false,
          colors: colors,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
      ],
      extraLinesData: ExtraLinesData(
        horizontalLines: hz,
      ),
      borderData: FlBorderData(
        show: false,
      ),
    );
  }
}
