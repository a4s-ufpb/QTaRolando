import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_events/app/app_module.dart';
import 'package:local_events/app/app_repository.dart';
import 'package:local_events/models/category.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/styleguide.dart';
import 'package:local_events/ui/event_details/event_details_page.dart';
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

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
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

  // _getEventos() {
  //   // Services.getEventos().then((eventos) {
  //   //   setState(() {
  //   //     _eventos = eventos;
  //   //   });
  //   // });
  //   repository.getEventos().then((eventos) {
  //     setState(() {
  //       _eventos = eventos;
  //     });
  //   });
  // }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    repository.getEventosStream();

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            color: Color(0x99FFFFFF),
                            size: 20,
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: !isSearching
                              ? Text(
                                  "QTaRolando?",
                                  style: whiteHeadingTextStyle,
                                )
                              : Flexible(
                                  child: TextField(
                                    autofocus: true,
                                    style: whiteHeadingTextStyle,
                                    decoration: InputDecoration(
                                      hintText: "Pesquisar ...",
                                      enabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                        ),
                        // Container(
                        //   width: whiteHeadingTextStyle.fontSize,
                        //   height: whiteHeadingTextStyle.fontSize,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey,
                        //   ),
                        // ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: appState.colorPrimary,
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
                                  child: CircularProgressIndicator(),
                                );
                              return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Container(
                                    child: ConstrainedBox(
                                      constraints: new BoxConstraints(),
                                      child: Column(
                                        children: <Widget>[
                                          for (final evento in snapshot.data
                                              .where((e) => e.categoryIds
                                                  .contains(appState
                                                      .selectedCategoryId)))
                                            InkWell(
                                              onTap: () {
                                                // Navigator.of(context).push(
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         EventDetailsPage(
                                                //             evento: evento,
                                                //             appState: appState),
                                                //   ),
                                                // );
                                                Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation1,
                                                            animation2) =>
                                                        EventDetailsPage(
                                                      evento: evento,
                                                      appState: appState,
                                                    ),
                                                    transitionsBuilder:
                                                        (context, animation1,
                                                            animation2, child) {
                                                      return FadeTransition(
                                                        opacity: animation1,
                                                        child: child,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              child: EventWidget(
                                                evento: evento,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
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
    );
  }
}
