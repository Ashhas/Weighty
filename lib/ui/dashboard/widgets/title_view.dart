import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  final String title;

  const TitleView({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        height: 25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).primaryTextTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }
}
