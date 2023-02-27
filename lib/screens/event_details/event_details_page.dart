import 'package:flutter/material.dart';
import 'package:local_events/models/event.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';
import 'event_details_content.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;
  final AppState appState;
  final bool themeIsDark;

  const EventDetailsPage(
      {Key key, this.event, this.appState, this.themeIsDark})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Event>.value(
        value: event,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            //EventDetailsBackground(),
            EventDetailsContent(
              appState: appState,
              themeIsDark: this.themeIsDark,
            ),
          ],
        ),
      ),
    );
  }
}
