import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barbones_architecture/util/theme.dart';

import "package:barbones_architecture/bloc/home/home_bloc.dart";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () =>
                  context.read<HomeBloc>().add(HomeButtonPressed("Tap!")),
              child: Text("Press!"),
              color: Theme.of(context).homeButtonDarkColor,
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Container();
                }
                if (state is HomeLoaded) {
                  return Text(state.homeText);
                }
                if (state is HomeError) {
                  return Text("Something Went wrong");
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
