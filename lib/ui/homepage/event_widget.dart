import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/styleguide.dart';
import 'package:local_events/ui/event_details/event_details_page.dart';
import 'package:share/share.dart';

import '../../app_state.dart';

class EventWidget extends StatelessWidget {
  final Evento evento;
  final AppState appState;
  final bool themeIsDark;

  const EventWidget({Key key, this.evento, this.appState, this.themeIsDark})
      : super(key: key);

  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError("string: $string");
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() +
        string[1].toLowerCase() +
        string[2].toLowerCase();
  }

  String getLocation(Evento evento) {
    final eventoLocation = evento.location.split(",");
    if (eventoLocation.length > 1) {
      return eventoLocation[0] + "," + eventoLocation[1];
    }
    return eventoLocation[0];
  }

  void share(BuildContext context, Evento evento) {
    final RenderBox box = context.findRenderObject();
    final String text =
        "${evento.title} - ${evento.punchLine1} ${evento.punchLine2}\nPara mais informações acesse: ${evento.site}";
    Share.share(
      text,
      subject: evento.description,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  void addEventToCalendar(Evento evento) {
    final Event event = Event(
      title: evento.title,
      description: evento.description,
      location: getLocation(evento),
      startDate: DateTime.parse(evento.initialDate),
      endDate: DateTime.parse(evento.finalDate),
    );
    Add2Calendar.addEvent2Cal(event);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }

        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => EventDetailsPage(
              evento: evento,
              appState: appState,
              themeIsDark: themeIsDark,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: themeIsDark ? Color(0xFF2d3033) : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Container(
                      color: Colors.grey,
                      child: Image.network(
                        evento.imagePath,
                        width: MediaQuery.of(context).size.width,
                        height: 125,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 125,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          width: 50,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                DateFormat.d("pt_BR")
                                    .format(DateTime.parse(evento.initialDate)),
                                style: eventLocationTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF212226),
                                ),
                              ),
                              Text(
                                capitalize(DateFormat.MMM("pt_BR").format(
                                    DateTime.parse(evento.initialDate))),
                                style: eventoDescription.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF212226),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            evento.title,
                            style: eventTitleTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              color: themeIsDark
                                  ? Colors.white
                                  : Color(0xFF212226),
                            ),
                          ),
                          SizedBox(height: 5),
                          FittedBox(
                            child: Material(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.solidCompass,
                                    size: 15,
                                    color: themeIsDark
                                        ? Colors.white
                                        : Color(0xFF212226),
                                  ),
                                  SizedBox(width: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Text(
                                      getLocation(evento),
                                      style: eventLocationTextStyle.copyWith(
                                        fontSize: 14,
                                        color: themeIsDark
                                            ? Colors.white
                                            : Color(0xFF212226),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                appState.colorPrimary,
                                appState.colorSecundary
                              ],
                              tileMode: TileMode.mirror,
                            ).createShader(bounds),
                            child: Container(
                              child: FaIcon(
                                FontAwesomeIcons.shareAlt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () => share(context, evento),
                        ),
                        IconButton(
                          icon: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                Color(0xFF98b4f9),
                                Color(0xFF798CF5),
                              ],
                              tileMode: TileMode.mirror,
                            ).createShader(bounds),
                            child: FaIcon(
                              FontAwesomeIcons.calendarAlt,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => addEventToCalendar(evento),
                        ),
                      ],
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
}
