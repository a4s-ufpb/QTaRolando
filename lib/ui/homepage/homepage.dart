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

  @override
  void initState() {
    super.initState();
    searchResult = "";
    isSearching = false;
    _getEventos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _getEventos();
    });
  }

  _getEventos() {
    setState(() {
      _eventos = repository.getEventosStream();
    });
  }

  Widget buildListByCategory(List<Evento> lista, AppState appState) {
    bool categoryIsEmpty = true;
    List<Widget> list = new List<Widget>();
    List<Widget> filtredList = new List<Widget>();
    if (isSearching && searchResult != "") {
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
      print(filtredList.length);

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
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
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
      isSearching = !isSearching;
      searchResult = "";
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
        body: ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
          child: Consumer<AppState>(
            builder: (context, appState, _) => Stack(
              children: <Widget>[
                HomePageBackground(
                  screenHeight: MediaQuery.of(context).size.height,
                ),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Eventos Locais",
                              style: fadedTextStyle,
                            ),
                            Spacer(),
                            Icon(
                              FontAwesomeIcons.user,
                              color: fadedTextStyle.color,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: !isSearching
                            ? InkWell(
                                onTap: changeSearching,
                                child: Text(
                                  "QTaRolando?",
                                  style: whiteHeadingTextStyle.copyWith(
                                      color: appState.colorPrimary),
                                ),
                              )
                            : Row(
                                children: <Widget>[
                                  Flexible(
                                    child: TextField(
                                      cursorColor: appState.colorPrimary,
                                      autofocus: true,
                                      style: whiteHeadingTextStyle.copyWith(
                                        color: appState.colorPrimary,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: -5),
                                        hintText: "Pesquisar ...",
                                        enabledBorder: InputBorder.none,
                                        focusColor: appState.colorPrimary,
                                      ),
                                      onChanged: (string) {
                                        setState(() {
                                          searchResult = string;
                                        });
                                      },
                                    ),
                                  ),
                                  InkWell(
                                    onTap: changeSearching,
                                    child: Container(
                                      width: whiteHeadingTextStyle.fontSize,
                                      height: whiteHeadingTextStyle.fontSize,
                                      child: Icon(
                                        FontAwesomeIcons.times,
                                        color: appState.colorPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // color: Color(0xFF202124),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x99000000),
                              blurRadius: 2.0,
                              spreadRadius: -4,
                              offset: Offset(0, 3),
                            ),
                          ],
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
                        child: Consumer<AppState>(
                          builder: (context, appState, _) => RefreshIndicator(
                            onRefresh: refreshList,
                            child: StreamBuilder<List<Evento>>(
                              stream: _eventos,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.grey,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          appState.colorPrimary),
                                    ),
                                  );
                                return SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Container(
                                      child: buildListByCategory(
                                          snapshot.data.toList(), appState),
                                    ),
                                  ),
                                );
                              },
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
