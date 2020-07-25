import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_events/app/app_module.dart';
import 'package:local_events/app/app_repository.dart';
import 'package:local_events/models/category.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/styleguide.dart';
import 'package:local_events/ui/homepage/category_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../app_state.dart';
import 'event_widget.dart';
import 'homepage_background.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var repository = AppModule.to.get<AppRepository>();
  Stream<List<Evento>> _eventos;

  String searchResult;
  bool isSearching;
  TextEditingController searchTextController = new TextEditingController();
  FocusNode focusInput = new FocusNode();

  bool hasInternet = true;

  bool themeIsDark = false;
  ThemeData themeData = ThemeData();

  @override
  void initState() {
    super.initState();
    _getThemeFromSharedPref();
    _setThemeData();
    searchResult = "";
    isSearching = false;
    _checkStatus();
    _getEventos();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _getEventos();
    });
  }

  Future<void> _getThemeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    this.setState(() {
      themeIsDark = prefs.getBool("themeDark") ?? false;
    });
  }

  Future<void> _setThemeForSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("themeDark", !themeIsDark);
    this.setState(() {
      themeIsDark = prefs.getBool("themeDark");
    });
    _setThemeData();
  }

  void _setThemeData() {
    this.setState(() {
      themeData = new ThemeData(
        textSelectionHandleColor:
            themeIsDark ? Colors.white : Color(0xFF444444),
      );
    });
  }

  _checkStatus() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          hasInternet = true;
        });
      } else {
        setState(() {
          hasInternet = false;
        });
      }
    });
  }

  _getEventos() {
    setState(() {
      _eventos = repository.getEventosStream();
    });
  }

  Widget buildListByCategory(
      List<Evento> lista, AppState appState, height, width) {
    bool categoryIsEmpty = true;
    List<Widget> list = new List<Widget>();
    List<Widget> filtredList = new List<Widget>();
    if (searchResult != "") {
      for (Evento evento in lista) {
        if (evento.title.toLowerCase().contains(searchResult.toLowerCase()) &&
            evento.categoryIds.contains(appState.selectedCategoryId)) {
          filtredList.add(new EventWidget(
            evento: evento,
            appState: appState,
            themeIsDark: this.themeIsDark,
          ));
          categoryIsEmpty = false;
        }
      }

      list.clear();
      list = filtredList;
    } else {
      for (Evento evento in lista) {
        if (evento.categoryIds.contains(appState.selectedCategoryId)) {
          list.add(new EventWidget(
            evento: evento,
            appState: appState,
            themeIsDark: this.themeIsDark,
          ));
          categoryIsEmpty = false;
        }
      }
    }

    if (categoryIsEmpty) {
      return Container(
        height: (height > 596.5) ? (height * 0.7) : (height * 0.6),
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              (searchResult != "")
                  ? FontAwesomeIcons.search
                  : FontAwesomeIcons.heartBroken,
              size: 40,
              color: appState.colorPrimary,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              (searchResult != "")
                  ? "Nenhum evento encontrado!"
                  : "Não há eventos no momento!",
              style: fadedTextStyle.copyWith(
                fontSize: 18,
                color: themeIsDark ? Colors.white38 : fadedTextStyle.color,
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      children: list,
    );
  }

  // _getEventos() {
  // Services.getEventos().then((eventos) {
  //   setState(() {
  //     _eventos = eventos;
  //   });
  // });
  // repository.getEventos().then((eventos) {
  //   setState(() {
  //     _eventos = eventos;
  //   });
  // });
  // }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    _getEventos();

    return null;
  }

  changeSearching() {
    setState(() {
      searchResult = "";
      searchTextController.clear();
    });
  }

  Widget shimmerEffect() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 15),
        elevation: 5,
        color: themeIsDark ? Color(0xFF3C4043) : Color(0xFFF1F3F4),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.black38,
                highlightColor: Colors.black12,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: 70,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.black38,
                  highlightColor: Colors.black12,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 125, height: 25, color: Colors.white),
                            SizedBox(height: 10),
                            FittedBox(
                              child: Material(
                                color: Colors.transparent,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.locationArrow,
                                      size: eventLocationTextStyle.fontSize,
                                      color: themeIsDark
                                          ? Color(0xFF212226)
                                          : Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                        width: 150,
                                        height: 15,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            width: 50, height: 25, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: themeIsDark ? Color(0xFF212226) : Colors.white,
        body: ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
          child: Consumer<AppState>(
            builder: (context, appState, _) => Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        color: themeIsDark ? Colors.white10 : Colors.black12,
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
                ),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "QTáRolando?",
                              style: whiteHeadingTextStyle.copyWith(
                                  color: appState.colorPrimary, fontSize: 35),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                themeIsDark
                                    ? FontAwesomeIcons.sun
                                    : FontAwesomeIcons.moon,
                                color: themeIsDark
                                    ? Colors.white
                                    : Color(0xFF212226),
                              ),
                              onPressed: () => _setThemeForSharedPref(),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: (focusInput.hasFocus || searchResult != "")
                                  ? themeIsDark
                                      ? Color(0xFF474C4F)
                                      : Colors.white
                                  : themeIsDark
                                      ? Color(0xFF212226)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow:
                                  (focusInput.hasFocus || searchResult != "")
                                      ? [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 1),
                                            blurRadius: 3.0,
                                          ),
                                        ]
                                      : []),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  enabled: hasInternet ? true : false,
                                  textAlignVertical: TextAlignVertical.top,
                                  focusNode: focusInput,
                                  controller: searchTextController,
                                  maxLines: 1,
                                  cursorColor:
                                      themeData.textSelectionHandleColor,
                                  style: fadedTextStyle.copyWith(
                                    fontSize: 16,
                                    color: themeIsDark
                                        ? Colors.white
                                        : fadedTextStyle.color,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: -5),
                                    icon: FaIcon(
                                      hasInternet
                                          ? FontAwesomeIcons.search
                                          : FontAwesomeIcons.lock,
                                      color: (focusInput.hasFocus ||
                                              searchResult != "")
                                          ? themeIsDark
                                              ? Colors.white
                                              : fadedTextStyle.color
                                          : themeIsDark
                                              ? Colors.white38
                                              : fadedTextStyle.color
                                                  .withOpacity(0.7),
                                    ),
                                    hintText: "Pesquisar ...",
                                    hintStyle: fadedTextStyle.copyWith(
                                      fontSize: 16,
                                      color: themeIsDark
                                          ? Colors.white38
                                          : fadedTextStyle.color
                                              .withOpacity(0.5),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (string) {
                                    setState(() {
                                      searchResult = string;
                                    });
                                  },
                                ),
                              ),
                              searchResult != ""
                                  ? InkWell(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: FaIcon(
                                          FontAwesomeIcons.times,
                                          size: 18,
                                        ),
                                      ),
                                      onTap: () {
                                        changeSearching();
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                Container(width: 8),
                                for (final category in categories)
                                  CategoryWidget(
                                    category: category,
                                    themeIsDark: this.themeIsDark,
                                  ),
                                Container(width: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: hasInternet
                            ? Consumer<AppState>(
                                builder: (context, appState, _) =>
                                    RefreshIndicator(
                                        backgroundColor: themeIsDark
                                            ? Color(0xFF212226)
                                            : Colors.white,
                                        color: fadedTextStyle.color,
                                        onRefresh: refreshList,
                                        child: StreamBuilder<List<Evento>>(
                                          stream: _eventos,
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData)
                                              return ListView.builder(
                                                itemCount: 10,
                                                // Important code
                                                itemBuilder: (context, index) =>
                                                    shimmerEffect(),
                                              );
                                            return ScrollConfiguration(
                                              behavior: ScrollBehavior(),
                                              child: GlowingOverscrollIndicator(
                                                color: appState.colorPrimary,
                                                axisDirection:
                                                    AxisDirection.down,
                                                child: ListView(
                                                  physics:
                                                      AlwaysScrollableScrollPhysics(),
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16.0),
                                                      child: Container(
                                                        child:
                                                            buildListByCategory(
                                                                snapshot.data
                                                                    .toList(),
                                                                appState,
                                                                screenHeight,
                                                                screenWidth),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )),
                              )
                            : Center(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.wifi,
                                            size: 40,
                                            color: appState.colorPrimary,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.slash,
                                            size: 45,
                                            color: themeIsDark
                                                ? Color(0xFF212226)
                                                : Colors.white,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.slash,
                                            size: 40,
                                            color: appState.colorPrimary,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Internet indisponível!",
                                        style: fadedTextStyle.copyWith(
                                            fontSize: 18),
                                      ),
                                      Text(
                                        "Tente novamente.",
                                        style: fadedTextStyle.copyWith(
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
