import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/models/category.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/services/eventServices.dart';
import 'package:local_events/styleguide.dart';
import 'package:local_events/widgets/event_widget.dart';
import 'package:local_events/widgets/filter_content_widget.dart';
import 'package:local_events/widgets/category_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomePage extends StatefulWidget {
  final bool themeIsDark;

  const HomePage({Key key, this.themeIsDark}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(themeIsDark);
}

class _HomePageState extends State<HomePage> {
  EventServices eventServices = EventServices();
  final _controllerCategories = ScrollController();

  //Used for search feature
  TextEditingController searchTextController = new TextEditingController();
  String searchResult;
  bool isSearching;

  final PagingController<int, Event> _pagingController =
      PagingController(firstPageKey: 0);
  static const _pageSize = 20;
  int pageKey;

  FocusNode focusInput = new FocusNode();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool hasInternet = true;
  bool themeIsDark;

  _HomePageState(this.themeIsDark);

  @override
  void initState() {
    int pageKey = 0;
    searchResult = "";
    isSearching = false;
    AppState appState;
    _checkStatus();

    if (_pagingController.itemList == null) {
      appState = Provider.of<AppState>(context, listen: false);
      _fetchPage(appState, pageKey);
    }

    _pagingController.addPageRequestListener((pageKey) {
      print("Entrou no listener");
      AppState newAppState = Provider.of<AppState>(context, listen: false);

      if(newAppState.equals(appState)) {
        appState = newAppState;
        _fetchPage(appState, pageKey);
      }
    });

    Provider.of<AppState>(context, listen: false).addListener(() {
      refreshList();
    });

    super.initState();
  }

  Future<void> _fetchPage(AppState appState, int pageKey) async {
    try {
      String dateType;
      if (appState.filterByDate == 'Hoje') {
        dateType = "HOJE";
      } else if (appState.filterByDate == 'Amanhã') {
        dateType = "AMANHA";
      } else if (appState.filterByDate == 'Esta Semana') {
        dateType = "ESTA_SEMANA";
      } else if (appState.filterByDate == 'Este Fim de Semana') {
        dateType = "FIM_SEMANA";
      } else if (appState.filterByDate == 'Proxima Semana') {
        dateType = "PROX_SEMANA";
      } else if (appState.filterByDate == 'Este Mês') {
        dateType = "ESTE_MES";
      }

      final events = await eventServices.getEventsFiltered(
        title: searchResult,
        page: pageKey,
        pageSize: _pageSize,
        modality: appState.filterByType,
        categoryId: appState.selectedCategoryId,
        dateType: dateType,
      );

      var newItems = events.where((event) {
        // If _pagingController.itemList is null, it is initialized with an empty list
        if (_pagingController.itemList == null) {
          _pagingController.itemList = [];
        }

        // Checks if the event is already in the list and returns true if it is not
        return !_pagingController.itemList.any((item) => item.id == event.id);
      }).toList();

      print('Filtered events: $newItems');

      final isLastPage = eventServices.isLast;
      print("PageKey: ${pageKey}  Total Pages ${eventServices.totalPages}");
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
        print("LastPage");
        print(_pagingController.itemList);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
        print("CurrentPage");
        print(_pagingController.itemList);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    searchTextController.dispose();
    _pagingController.dispose();

    Provider.of<AppState>(context, listen: false).removeListener(() {
      refreshList();
    });

    super.dispose();
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

  Future<void> _setThemeForSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("themeDark", !themeIsDark);
    this.setState(() {
      themeIsDark = prefs.getBool("themeDark");
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _checkStatus();
    _pagingController.refresh();
    int pageKey = 0;
    setState(() {
      _fetchPage(Provider.of<AppState>(context, listen: false), pageKey);
    });
    return null;
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val != "listening") {
            setState(() {
              _isListening = false;
              _speech.stop();
            });
          }
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (val) => setState(() {
            searchResult = val.recognizedWords;
            searchTextController.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }

  void clearSearch() {
    setState(() {
      searchResult = "";
      searchTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _isListening
            ? AvatarGlow(
                animate: _isListening,
                glowColor: Colors.redAccent,
                endRadius: 50,
                duration: Duration(milliseconds: 2000),
                repeatPauseDuration: Duration(milliseconds: 100),
                repeat: true,
                child: FloatingActionButton(
                  child: FaIcon(
                    FontAwesomeIcons.microphoneSlash,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.redAccent,
                  onPressed: () {
                    setState(() {
                      _isListening = false;
                      _speech.stop();
                    });
                  },
                ),
              )
            : null,
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: Consumer<AppState>(
          builder: (context, appState, _) => Stack(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                  ),
                  Container(
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            "QTáRolando?",
                            style: whiteHeadingTextStyle.copyWith(
                              foreground: Paint()
                                ..shader = LinearGradient(
                                  colors: [
                                    appState.colorPrimary,
                                    appState.colorSecundary,
                                  ],
                                ).createShader(
                                  Rect.fromLTWH(
                                    0.0,
                                    0.0,
                                    200.0,
                                    70.0,
                                  ),
                                ),
                              fontSize: 35,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Container(
                              child: SvgPicture.asset(
                                (Theme.of(context).primaryColor ==
                                        darkTheme.primaryColor)
                                    ? "assets/icons/sun.svg"
                                    : "assets/icons/moon.svg",
                                color: Theme.of(context).buttonColor,
                              ),
                            ),
                            onPressed: () {
                              _setThemeForSharedPref();
                              AdaptiveTheme.of(context).toggleThemeMode();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: searchBar(),
                          ),
                          InkWell(
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.all(12),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                boxShadow: (appState.filterByDate.isNotEmpty ||
                                        appState.filterByType.isNotEmpty)
                                    ? [
                                        BoxShadow(
                                            blurRadius: 3,
                                            offset: Offset(0, 1),
                                            color: Colors.black26)
                                      ]
                                    : [],
                                gradient: LinearGradient(
                                    begin: AlignmentDirectional.centerStart,
                                    end: AlignmentDirectional.centerEnd,
                                    colors: (appState.filterByDate.isNotEmpty ||
                                            appState.filterByType.isNotEmpty)
                                        ? [
                                            appState.colorPrimary,
                                            appState.colorSecundary
                                          ]
                                        : [
                                            Theme.of(context).primaryColor,
                                            Theme.of(context).primaryColor
                                          ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/filter_alt_black_24dp.svg",
                                color: (appState.filterByDate.isNotEmpty ||
                                        appState.filterByType.isNotEmpty)
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).buttonColor,
                              ),
                            ),
                            onTap: () => showFiltersBottomSheet(appState),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: FadingEdgeScrollView.fromSingleChildScrollView(
                        child: SingleChildScrollView(
                          controller: _controllerCategories,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              for (final category in categories)
                                CategoryWidget(category: category),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: Consumer<AppState>(
                        builder: (context, appState, _) => RefreshIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                          color: Colors.grey[400],
                          onRefresh: refreshList,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: FutureBuilder<void>(
                              future: _fetchPage(appState, pageKey),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return (_pagingController.itemList != null &&
                                          _pagingController.itemList.isNotEmpty)
                                      ? PagedListView<int, Event>(
                                          pagingController: _pagingController,
                                          builderDelegate:
                                              PagedChildBuilderDelegate<Event>(
                                            itemBuilder:
                                                (context, item, index) =>
                                                    EventWidget(
                                              event: item,
                                              appState: appState,
                                              themeIsDark: themeIsDark,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          width: MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 12.0),
                                                child: ShaderMask(
                                                  shaderCallback: (bounds) =>
                                                      LinearGradient(
                                                    colors: [
                                                      appState.colorPrimary,
                                                      appState.colorSecundary
                                                    ],
                                                    tileMode: TileMode.mirror,
                                                  ).createShader(bounds),
                                                  child: Container(
                                                    width: 45,
                                                    height: 45,
                                                    child: Icon(
                                                      (searchResult != "")
                                                          ? FontAwesomeIcons
                                                              .search
                                                          : FontAwesomeIcons
                                                              .heartBroken,
                                                      size: 40,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                (searchResult != "")
                                                    ? "Nenhum evento encontrado!"
                                                    : "Não há eventos no momento!",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3,
                                              ),
                                            ],
                                          ),
                                        );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: focusInput.hasFocus || searchResult != ""
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              focusNode: focusInput,
              controller: searchTextController,
              maxLines: 1,
              cursorColor: Theme.of(context).textSelectionTheme.selectionColor,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.headline4,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: -5),
                icon: FaIcon(
                  FontAwesomeIcons.search,
                  color: focusInput.hasFocus || searchResult != ""
                      ? Theme.of(context).buttonColor
                      : Theme.of(context).buttonColor.withOpacity(.5),
                ),
                hintText: "Pesquisar evento",
                hintStyle: Theme.of(context).textTheme.headline4.copyWith(
                      color: Theme.of(context).buttonColor.withOpacity(.5),
                    ),
                border: InputBorder.none,
              ),
              onChanged: (string) {
                refreshList();
                setState(() {
                  searchResult = string;
                });
              },
            ),
          ),
          searchResult != ""
              ? InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: FaIcon(
                      FontAwesomeIcons.times,
                      size: 18,
                      color: Theme.of(context).buttonColor.withOpacity(.5),
                    ),
                  ),
                  onTap: clearSearch,
                )
              : _isListening == false
                  ? InkWell(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: FaIcon(
                          FontAwesomeIcons.microphone,
                          size: 18,
                          color: Theme.of(context).buttonColor.withOpacity(.5),
                        ),
                      ),
                      onTap: _listen,
                    )
                  : Container(),
        ],
      ),
    );
  }

  void showFiltersBottomSheet(AppState appState) {
    setState(() {
      refreshList();
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      builder: (context) => FilterContentWidget(
        appState: appState
      ),
    );
  }
}
