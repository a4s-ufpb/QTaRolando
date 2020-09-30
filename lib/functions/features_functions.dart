import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:local_events/functions/utils_functions.dart';
import 'package:local_events/models/event.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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
    location: getLocation(evento.location),
    startDate: DateTime.parse(evento.initialDate),
    endDate: DateTime.parse(evento.finalDate),
  );
  Add2Calendar.addEvent2Cal(event);
}

void call(Evento evento) async {
  launch('tel:${evento.phone.toString()}');
}

void goToWebsite(Evento evento) async {
  if (await canLaunch(evento.site)) {
    await launch(evento.site);
  }
}

void openMap(Evento evento) async {
  if (await MapLauncher.isMapAvailable(MapType.google)) {
    await MapLauncher.showMarker(
      mapType: MapType.google,
      coords: Coords(
          getCoodenadas(evento.location)[0], getCoodenadas(evento.location)[1]),
      title: evento.title,
      description: evento.description,
    );
  }
}
