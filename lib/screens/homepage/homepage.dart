import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_events/app/app_module.dart';
import 'package:local_events/app/app_repository.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/models/category.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/styleguide.dart';
import 'package:local_events/widgets/filter_content_widget.dart';
import 'package:local_events/widgets/category_widget.dart';
import 'package:local_events/widgets/list_events_widget.dart';
import 'package:local_events/widgets/shimmer_effect_widget.dart';
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
  var repository = AppModule.to.get<AppRepository>();
  Stream<List<Evento>> _eventos;

  final _controllerCategories = ScrollController();
  final _controllerEventos = ScrollController();

  //Used for search feature
  String searchResult;
  bool isSearching;
  TextEditingController searchTextController = new TextEditingController();
  FocusNode focusInput = new FocusNode();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  bool hasInternet = true;

  bool themeIsDark;

  _HomePageState(this.themeIsDark);

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

  Future<void> _setThemeForSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("themeDark", !themeIsDark);
    this.setState(() {
      themeIsDark = prefs.getBool("themeDark");
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    _getEventos();

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
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "QTáRolando?",
                              style: whiteHeadingTextStyle.copyWith(
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: <Color>[
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
                          children: <Widget>[
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
                                  boxShadow:
                                      ((appState.filterByDate.isNotEmpty ||
                                              appState.filterByType.isNotEmpty))
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
                                      colors: (appState
                                                  .filterByDate.isNotEmpty ||
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
                                  "assets/icons/preferences.svg",
                                  color: (appState.filterByDate.isNotEmpty ||
                                          appState.filterByType.isNotEmpty)
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).buttonColor,
                                ),
                              ),
                              onTap: () => _buildBottomSheetFilters(appState),
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
                              children: <Widget>[
                                SizedBox(width: 8),
                                for (final category in categories)
                                  CategoryWidget(
                                    category: category,
                                  ),
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
                          child: StreamBuilder<List<Evento>>(
                            stream: _eventos,
                            builder: (context, snapshot) {
                              if (hasInternet && !snapshot.hasData) {
                                if (!snapshot.hasData)
                                  return AnimationLimiter(
                                    child: ListView.builder(
                                      itemCount: 5,
                                      itemBuilder: (context, index) =>
                                          AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration: Duration(milliseconds: 475),
                                        child: SlideAnimation(
                                          horizontalOffset: 50,
                                          child: FadeInAnimation(
                                            child: ShimmerEffectWidget(
                                                themeIsDark: themeIsDark),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                              } else if (hasInternet || snapshot.hasData) {
                                return NotificationListener<
                                    OverscrollIndicatorNotification>(
                                  onNotification:
                                      (OverscrollIndicatorNotification
                                          overScroll) {
                                    overScroll.disallowGlow();
                                    return false;
                                  },
                                  child: FadingEdgeScrollView.fromScrollView(
                                    child: ListView(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      controller: _controllerEventos,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: ListEventsWidget(
                                            listaEventos:
                                                snapshot.data.toList(),
                                            appState: appState,
                                            themeIsDark: themeIsDark,
                                            searchResult: searchResult,
                                          ),
                                        ),
                                        !hasInternet
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16.0,
                                                  vertical: 15.0,
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: ShaderMask(
                                                        shaderCallback:
                                                            (bounds) =>
                                                                LinearGradient(
                                                          colors: [
                                                            appState
                                                                .colorPrimary,
                                                            appState
                                                                .colorSecundary
                                                          ],
                                                          tileMode:
                                                              TileMode.mirror,
                                                        ).createShader(bounds),
                                                        child: Container(
                                                          width: 60,
                                                          height: 60,
                                                          child: SvgPicture.asset(
                                                              'assets/icons/no_wifi.svg',
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "Não há conexão com a Internet. Ative o Wi-Fi ou dados e tente novamente.",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Row(),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Center(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ShaderMask(
                                        shaderCallback: (bounds) =>
                                            LinearGradient(
                                          colors: [
                                            appState.colorPrimary,
                                            appState.colorSecundary
                                          ],
                                          tileMode: TileMode.mirror,
                                        ).createShader(bounds),
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          child: SvgPicture.asset(
                                              'assets/icons/no_wifi.svg',
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Não há conexão com a Internet.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                      Text(
                                        "Ative o Wi-Fi ou dados e tente novamente.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
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
        color: (focusInput.hasFocus || searchResult != "")
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              focusNode: focusInput,
              controller: searchTextController,
              maxLines: 1,
              cursorColor: Theme.of(context).textSelectionColor,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.headline4,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: -5),
                icon: FaIcon(
                  FontAwesomeIcons.search,
                  color: (focusInput.hasFocus || searchResult != "")
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
              : (_isListening == false)
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

  void _buildBottomSheetFilters(AppState appState) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      builder: (context) {
        return Container(
          child: FilterContentWidget(appState: appState),
        );
      },
    );
  }
}
