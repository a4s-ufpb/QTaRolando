import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/styleguide.dart';
import 'package:local_events/ui/event_details/event_details_page.dart';

import '../../app_state.dart';

class EventWidget extends StatelessWidget {
  final Evento evento;
  final AppState appState;
  final bool themeIsDark;

  const EventWidget({Key key, this.evento, this.appState, this.themeIsDark})
      : super(key: key);

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
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 15),
        elevation: 5,
        shadowColor: Colors.black,
        color: appState.colorPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: evento.imagePath,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    color: Colors.grey,
                    child: Image.network(
                      evento.imagePath,
                      height: 70,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
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
                              color: themeIsDark
                                  ? Color(0xFF212226)
                                  : Colors.white,
                            ),
                          ),
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
                                  Text(
                                    evento.location,
                                    style: eventLocationTextStyle.copyWith(
                                      color: themeIsDark
                                          ? Color(0xFF212226)
                                          : Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        evento.duration.toUpperCase(),
                        textAlign: TextAlign.right,
                        style: eventLocationTextStyle.copyWith(
                          fontWeight: FontWeight.w900,
                          color: themeIsDark ? Color(0xFF212226) : Colors.white,
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
}
