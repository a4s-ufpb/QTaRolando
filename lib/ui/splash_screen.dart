import 'package:flutter/material.dart';
import 'package:local_events/styleguide.dart';
import 'package:local_events/ui/homepage/homepage.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenWidget extends StatefulWidget {
  Color backgroundColor;
  SplashScreenWidget({Key key, this.backgroundColor}) : super(key: key);

  @override
  _SplashScrenWidgetState createState() => _SplashScrenWidgetState();
}

class _SplashScrenWidgetState extends State<SplashScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SplashScreen(
            seconds: 2,
            backgroundColor: widget.backgroundColor,
            navigateAfterSeconds: HomePage(),
            loaderColor: Colors.transparent,
          ),
          Center(
            child: Container(
              height: 104,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 3)
                ],
                image: DecorationImage(
                  image: AssetImage("assets/icons/app_icon.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "from",
                      style: fadedTextStyle.copyWith(
                        fontSize: 20,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Container(
                  height: 28,
                  width: 148,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
