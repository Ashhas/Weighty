import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/ui/dashboard/widgets/chart_widget.dart';
import 'package:weighty/ui/dashboard/widgets/statistic_grid.dart';
import 'package:weighty/ui/dashboard/widgets/title_view.dart';
import 'package:weighty/util/constants/ui_const.dart';

class WeightStatisticsWidget extends StatefulWidget {
  WeightStatisticsWidget() : super();

  @override
  _WeightStatisticsWidgetState createState() => _WeightStatisticsWidgetState();
}

class _WeightStatisticsWidgetState extends State<WeightStatisticsWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is DashboardLoaded) {
                      return IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Column(
                            children: [
                              TitleView(
                                title: UiConst.cardStatisticsTitle,
                              ),
                              StatisticGrid(
                                amountLeft: state.amountLeft,
                                percentageDone: state.percentageDone,
                                totalLost: state.totalLost,
                                unitType: state.unitType,
                              ),
                              SizedBox(height: 30),
                              TitleView(
                                title: UiConst.cardWeightGraphTitle,
                              ),
                              SmallWeightChartWidget(),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
