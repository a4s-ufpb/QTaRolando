import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_events/ui/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  bool _themeDark = false;

  @override
  void initState() {
    super.initState();
    _getThemeFromSharedPref();
  }

  Future<void> _getThemeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIsDark = prefs.getBool("themeDark");
    this.setState(() {
      _themeDark = themeIsDark ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QTaRolando?',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        primaryColor: Color(0xFFF4F4F4),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionColor: Colors.black45,
      ),
      home: SplashScreenWidget(
          backgroundColor: _themeDark ? Color(0xFF212226) : Colors.white),
    );
  }
}
