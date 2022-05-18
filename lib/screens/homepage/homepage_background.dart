import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';

class HomePageBackground extends StatelessWidget {
  final screenHeight;

  const HomePageBackground({Key key, @required this.screenHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final Color colorBackground = appState.colorPrimary;

    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
        ),
        Container(
          // color: Color(0xFF202124),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              alignment: Alignment.bottomLeft,
              image: AssetImage("assets/images/sky_background.png"),
            ),
          ),
        ),
      ],
    );
  }
}
