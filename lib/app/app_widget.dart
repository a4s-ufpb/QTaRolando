import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_events/ui/splash_screen.dart';

class AppWidget extends StatelessWidget {
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
        textSelectionColor: Color(0xFF444444).withOpacity(0.5),
        textSelectionHandleColor: Color(0xFF444444),
      ),
      home: SplashScreenWidget(),
    );
  }
}
