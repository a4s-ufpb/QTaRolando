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

  @override
  void initState() {
    super.initState();
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
              style: fadedTextStyle.copyWith(fontSize: 18),
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

    repository.getEventosStream();

    return null;
  }

  changeSearching() {
    setState(() {
      searchResult = "";
      searchTextController.clear();
    });
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
        body: ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
          child: Consumer<AppState>(
            builder: (context, appState, _) => Stack(
              children: <Widget>[
                HomePageBackground(
                  screenHeight: screenHeight,
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
                            Container(
                              alignment: Alignment.center,
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                shape: BoxShape.circle,
                              ),
                              // child: Icon(
                              //   FontAwesomeIcons.user,
                              //   color: Colors.white,
                              //   size: 20,
                              // ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: (focusInput.hasFocus || searchResult != "")
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
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
                                  cursorColor: Theme.of(context)
                                      .textSelectionHandleColor,
                                  style: fadedTextStyle.copyWith(fontSize: 16),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: -5),
                                    icon: FaIcon(
                                      hasInternet
                                          ? FontAwesomeIcons.search
                                          : FontAwesomeIcons.lock,
                                      color: (focusInput.hasFocus ||
                                              searchResult != "")
                                          ? appState.colorPrimary
                                          : appState.colorPrimary
                                              .withOpacity(0.8),
                                    ),
                                    hintText: "Pesquisar ...",
                                    hintStyle: fadedTextStyle.copyWith(
                                      fontSize: 16,
                                      color:
                                          fadedTextStyle.color.withOpacity(0.5),
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
                                  CategoryWidget(category: category),
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
                                        backgroundColor: Colors.white,
                                        color: fadedTextStyle.color,
                                        onRefresh: refreshList,
                                        child: StreamBuilder<List<Evento>>(
                                          stream: _eventos,
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData)
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: Colors.grey,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          appState
                                                              .colorPrimary),
                                                ),
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
                                            color: Colors.white,
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
