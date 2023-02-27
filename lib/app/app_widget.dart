import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/styleguide.dart';
import 'package:local_events/screens/splash_screen.dart';
import 'package:provider/provider.dart';
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

  Future<bool> _getThemeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIsDark = prefs.getBool("themeDark");
    setState(() {
      _themeDark = themeIsDark ?? false;
    });
    return themeIsDark ?? false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: FutureBuilder(
        future: _getThemeFromSharedPref(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            debugShowCheckedModeBanner: false,
            title: 'QTáRolando?',
            theme: _themeDark ? darkTheme : lightTheme,
            darkTheme: darkTheme,
            home: SplashScreenWidget(themeIsDark: _themeDark),
          )
              : Material();
        },
      ),
    );
  }
}
