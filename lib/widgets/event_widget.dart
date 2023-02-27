import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/functions/features_functions.dart';
import 'package:local_events/functions/utils_functions.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/screens/event_details/event_details_page.dart';

import '../themes/app_images.dart';

class EventWidget extends StatelessWidget {
  final Event event;
  final AppState appState;
  final bool themeIsDark;

  const EventWidget({Key key, this.event, this.appState, this.themeIsDark})
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
              event: event,
              appState: appState,
              themeIsDark: themeIsDark,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
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
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            appState.colorPrimary,
                            appState.colorSecundary,
                          ],
                        ),
                      ),
                      child: FadeInImage.assetNetwork(
                        image: event.imagePath,
                        width: MediaQuery.of(context).size.width,
                        height: 125,
                        fit: BoxFit.cover,
                        placeholder: AppImages.placeholder,
                      ),
                    ),
                  ),
                  Container(
                    height: 125,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Stack(
                          children: <Widget>[
                            if (event.initialDate.year != DateTime.now().year)
                              Container(
                                width: 76,
                                height: 55,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      appState.colorPrimary,
                                      appState.colorSecundary,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                      blurRadius: 3.0,
                                    ),
                                  ],
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: RotatedBox(
                                    quarterTurns: 1,
                                    child: RichText(
                                      text: TextSpan(
                                        text: "${event.initialDate.year}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              width: 50,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
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
                                    DateFormat("dd", "pt_BR")
                                        .format(event.initialDate),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  Text(
                                    capitalize(DateFormat.MMM("pt_BR")
                                        .format(event.initialDate)),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 16,
                  right: 16,
                  bottom: 8,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            event.title,
                            style: Theme.of(context).textTheme.headline2,
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
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .color,
                                  ),
                                  SizedBox(width: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Text(
                                      getLocation(event.location),
                                      style:
                                          Theme.of(context).textTheme.headline3,
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
                        _buildBottom(
                            FontAwesomeIcons.shareAlt,
                            appState.colorPrimary,
                            appState.colorSecundary,
                            context),
                        _buildBottom(FontAwesomeIcons.calendarAlt,
                            Color(0xFF98b4f9), Color(0xFF798CF5), context),
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

  Widget _buildBottom(IconData icon, Color colorPrimary, Color colorSecundary,
      BuildContext context) {
    return IconButton(
      icon: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [
            colorPrimary,
            colorSecundary,
          ],
          tileMode: TileMode.mirror,
        ).createShader(bounds),
        child: Container(
          margin: EdgeInsets.all(1),
          child: FaIcon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
      onPressed: () {
        if (icon == FontAwesomeIcons.calendarAlt) addEventToCalendar(event);
        if (icon == FontAwesomeIcons.shareAlt) share(context, event);
      },
    );
  }
}
