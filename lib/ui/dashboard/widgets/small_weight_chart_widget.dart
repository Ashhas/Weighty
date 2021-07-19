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
  List<Color> lineColors = [Color(0xFF3f51b5).withOpacity(0.8)];
  List<Color> underBarColors = [Color(0xFF3f51b5).withOpacity(0.1)];
  List<int> dashLine = [5];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoaded) {
          return AspectRatio(
            aspectRatio: 2.3,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 19,
                  bottom: 12,
                  left: 15,
                  right: 15,
                ),
                child: LineChart(
                  mainData(state.startWeight, state.targetWeight,
                      state.filteredMeasurements),
                ),
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
        color: Colors.grey.withOpacity(0.2),
        y: startWeight,
        dashArray: dashLine,
        label: HorizontalLineLabel(
          show: true,
          style: TextStyle(color: Colors.black),
        ),
      ),
      HorizontalLine(
        color: Colors.grey.withOpacity(0.2),
        y: targetWeight,
        dashArray: dashLine,
        label: HorizontalLineLabel(
          show: true,
          style: TextStyle(color: Colors.black),
        ),
      ),
    ];

    return filteredList != null
        ? LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              drawHorizontalLine: false,
              verticalInterval: 1,
              horizontalInterval: 5,
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: false,
                reservedSize: 35,
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
                margin: 8,
              ),
              leftTitles: SideTitles(
                showTitles: false,
              ),
            ),
            borderData: FlBorderData(show: false),
            minX: filteredList.first.dateAdded.day.toDouble(),
            maxX: filteredList.last.dateAdded.day.toDouble() + 0.5,
            minY: targetWeight,
            maxY: startWeight + 2,
            lineBarsData: [
              LineChartBarData(
                spots: filteredList
                    .map((element) => FlSpot(
                        element.dateAdded.day.toDouble(), element.weightEntry))
                    .toList(),
                isCurved: true,
                colors: lineColors,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  spotsLine: BarAreaSpotsLine(
                    show: true,
                    flLineStyle: FlLine(
                      color: Colors.grey.withOpacity(0.5),
                      strokeWidth: 0.6,
                    ),
                  ),
                  colors: underBarColors.toList(),
                ),
              )
            ],
            extraLinesData: ExtraLinesData(
              horizontalLines: hz,
            ),
          )
        : LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              drawHorizontalLine: false,
              verticalInterval: 1,
              horizontalInterval: 5,
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: false,
                margin: 8,
              ),
              leftTitles: SideTitles(
                showTitles: false,
              ),
            ),
            borderData: FlBorderData(show: false),
            minY: targetWeight,
            maxY: startWeight + 2,
            lineBarsData: [],
            extraLinesData: ExtraLinesData(
              horizontalLines: hz,
            ),
          );
  }
}
