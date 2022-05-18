import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local_events/styleguide.dart';
import 'package:local_events/screens/splash_screen.dart';
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
    this.setState(() {
      _themeDark = themeIsDark ?? false;
    });
    return themeIsDark ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final isPlatformDark = _themeDark;
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    return FutureBuilder(
      future: _getThemeFromSharedPref(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? AdaptiveTheme(
                light: lightTheme,
                dark: darkTheme,
                initial: isPlatformDark
                    ? AdaptiveThemeMode.dark
                    : AdaptiveThemeMode.light,
                builder: (theme, darkTheme) => MaterialApp(
                      localizationsDelegates: [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate
                      ],
                      debugShowCheckedModeBanner: false,
                      title: 'QTáRolando?',
                      theme: theme,
                      darkTheme: darkTheme,
                      home: SplashScreenWidget(themeIsDark: _themeDark),
                    ))
            : Material();
      },
    );
  }
}
