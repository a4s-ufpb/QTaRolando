import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/functions/filter_functions.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/widgets/event_widget.dart';

class ListEventsWidget extends StatefulWidget {
  final String searchResult;
  final AppState appState;
  final List<Evento> listaEventos;
  final bool themeIsDark;

  const ListEventsWidget({
    Key key,
    this.searchResult,
    this.appState,
    this.listaEventos,
    this.themeIsDark,
  }) : super(key: key);

  @override
  _ListEventsWidgetState createState() => _ListEventsWidgetState();
}

class _ListEventsWidgetState extends State<ListEventsWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return buildListByCategory(widget.listaEventos, widget.appState,
        screenHeight, screenWidth, widget.searchResult, widget.themeIsDark);
  }

  Widget buildListByCategory(List<Evento> lista, AppState appState,
      double height, double width, String searchResult, bool themeIsDark) {
    bool categoryIsEmpty = true;
    List<EventWidget> list = new List<EventWidget>();
    List<EventWidget> filtredListByCategory = new List<EventWidget>();
    List<EventWidget> filterByFilters = new List<EventWidget>();
    if (searchResult != "") {
      for (Evento evento in lista) {
        if (evento.title.toLowerCase().contains(searchResult.toLowerCase()) &&
            evento.categoryIds.contains(appState.selectedCategoryId)) {
          filtredListByCategory.add(new EventWidget(
            evento: evento,
            appState: appState,
            themeIsDark: themeIsDark,
          ));
          categoryIsEmpty = false;
        }
      }

      list.clear();
      list = filtredListByCategory;
    } else {
      for (Evento evento in lista) {
        if (evento.categoryIds.contains(appState.selectedCategoryId)) {
          list.add(new EventWidget(
            evento: evento,
            appState: appState,
            themeIsDark: themeIsDark,
          ));
          categoryIsEmpty = false;
        }
      }
    }

    if (categoryIsEmpty) {
      return _buildListEmpityWidget(appState, width, searchResult);
    }

    if (appState.filterByDate != "" || appState.filterByType != "") {
      if (appState.filterByDate == "Hoje" &&
          appState.filterByType == "Online") {
        for (EventWidget eventWidget in list) {
          filterHojeEAmanha(eventWidget, filterByFilters);
        }
      } else if (appState.filterByDate == "Hoje" &&
          appState.filterByType == "Presencial") {
        for (EventWidget eventWidget in list) {
          filterHojeEPresencial(eventWidget, filterByFilters);
        }
      } else if (appState.filterByDate == "Hoje" &&
          appState.filterByType.isEmpty) {
        for (EventWidget eventWidget in list) {
          filterHoje(eventWidget, filterByFilters);
        }
      } else if (appState.filterByDate == "Este mês" &&
          appState.filterByType == "Online") {
        for (EventWidget eventWidget in list) {
          filterEsteMesEOnline(eventWidget, filterByFilters);
        }
      } else if (appState.filterByDate == "Este mês" &&
          appState.filterByType == "Presencial") {
        for (EventWidget eventWidget in list) {
          filterEsteMesEPresencial(eventWidget, filterByFilters);
        }
      } else if (appState.filterByDate == "Este mês" &&
          appState.filterByType.isEmpty) {
        for (EventWidget eventWidget in list) {
          filterEsteMes(eventWidget, filterByFilters);
        }
      } else if (appState.filterByDate == "Próx. mês" &&
          appState.filterByType == "Online") {
        for (EventWidget eventWidget in list) {
          filterProxMesEOnline(eventWidget, filterByFilters);
        }
      } else if (appState.filterByDate == "Próx. mês" &&
          appState.filterByType == "Presencial") {
        for (EventWidget eventWidget in list) {
          filterProxMesEPresencial(eventWidget, filterByFilters);
        }
      } else if (appState.filterByDate == "Próx. mês" &&
          appState.filterByType.isEmpty) {
        for (EventWidget eventWidget in list) {
          filterProxMes(eventWidget, filterByFilters);
        }
      } else if (appState.filterByDate.isEmpty &&
          appState.filterByType == "Online") {
        for (EventWidget eventWidget in list) {
          if (eventWidget.evento.location == "Online") {
            filterByFilters.add(eventWidget);
          }
        }
      } else if (appState.filterByDate.isEmpty &&
          appState.filterByType == "Presencial") {
        for (EventWidget eventWidget in list) {
          if (eventWidget.evento.location != "Online") {
            filterByFilters.add(eventWidget);
          }
        }
      }
      if (filterByFilters.isEmpty) {
        return _buildListEmpityWidget(appState, width, searchResult);
      }

      return _buildColumn(filterByFilters, appState);
    }

    return _buildColumn(list, appState);
  }

  Widget _buildColumn(List<EventWidget> list, AppState appState) {
    // List<Widget> groupedList = [];
    // var groupByYear = groupBy(
    //     list, (EventWidget obj) => DateTime.parse(obj.evento.initialDate).year);
    // groupByYear.forEach((year, list) {
    //   // Header
    //   groupedList.add(
    //     Container(
    //       padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.only(
    //           topRight: Radius.circular(25),
    //           bottomRight: Radius.circular(25),
    //         ),
    //       ),
    //       child: Row(
    //         children: <Widget>[
    //           FaIcon(
    //             FontAwesomeIcons.caretRight,
    //             color: Theme.of(context).buttonColor,
    //           ),
    //           SizedBox(width: 8),
    //           Text(
    //             "$year",
    //             style: Theme.of(context).textTheme.headline1.copyWith(
    //                 foreground: Paint()
    //                   ..shader = LinearGradient(
    //                     colors: <Color>[
    //                       appState.colorPrimary,
    //                       appState.colorSecundary,
    //                     ],
    //                   ).createShader(
    //                     Rect.fromLTWH(
    //                       0.0,
    //                       0.0,
    //                       200.0,
    //                       70.0,
    //                     ),
    //                   ),
    //                 fontSize: 20),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );

    //   // Group
    //   list.forEach((listItem) {
    //     // List item
    //     groupedList.add(Padding(
    //       padding: const EdgeInsets.only(left: 16.0, right: 16),
    //       child: listItem,
    //     ));
    //   });
    // });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget _buildListEmpityWidget(
      AppState appState, double width, String searchResult) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [appState.colorPrimary, appState.colorSecundary],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              child: Container(
                width: 45,
                height: 45,
                child: Icon(
                  (searchResult != "")
                      ? FontAwesomeIcons.search
                      : FontAwesomeIcons.heartBroken,
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
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
