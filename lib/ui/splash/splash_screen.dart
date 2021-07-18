import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weighty/bloc/app_init/initialization_bloc.dart';
import 'package:weighty/ui/bottom_nav_bar.dart';
import 'package:weighty/ui/on_boarding/on_boarding_entry_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitializationBloc, InitializationState>(
      builder: (context, initState) {
        if (initState is InitStarted) {
          return Container(color: Colors.deepOrangeAccent);
        } else if (initState is Uninitialized) {
          return OnBoardingEntryScreen();
        } else if (initState is Initialized) {
          return BottomNavBar();
        } else {
          return Container();
        }
      },
    );
  }
}
