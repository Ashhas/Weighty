import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weighty/bloc/dashboard/dashboard_bloc.dart';
import 'package:weighty/ui/dashboard/widgets/weight_progress_card.dart';
import 'package:weighty/ui/dashboard/widgets/weight_stats_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen() : super();

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DashboardBloc>(context).add(DashboardStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoaded) {
            return Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  _buildAppBar(),
                  SizedBox(height: 25),
                  WeightProgressCard(),
                  SizedBox(height: 25),
                  WeightStatsWidget(),
                ],
              ),
            );
          } else {
            return Container(
              color: Theme.of(context).backgroundColor,
            );
          }
        },
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      title: Text(
        "Weighty",
        style: GoogleFonts.roboto(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}
