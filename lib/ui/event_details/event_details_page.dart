import 'package:flutter/material.dart';
import 'package:local_events/models/event.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';
import 'event_details_background.dart';
import 'event_details_content.dart';

class EventDetailsPage extends StatelessWidget {
  final Evento evento;
  final AppState appState;

  const EventDetailsPage({Key key, this.evento, this.appState})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Evento>.value(
        value: evento,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            EventDetailsBackground(),
            EventDetailsContent(colorPunchLine1: appState.colorPrimary),
          ],
        ),
      ),
    );
  }
}
