import 'package:add_2_calendar/add_2_calendar.dart' as calendar;
import 'package:flutter/material.dart';
import 'package:local_events/functions/utils_functions.dart';
import 'package:local_events/models/coordinates.dart';
import 'package:local_events/models/event.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

void share(BuildContext context, Event event) {
  final RenderBox box = context.findRenderObject();
  final String text =
      "${event.title} - ${event.subtitle}\nPara mais informações acesse: ${event
      .site.isNotEmpty? event.site : "Informação não disponível"}";
  Share.share(
    text,
    subject: event.description,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}

void addEventToCalendar(Event event) {
  final calendar.Event calendarEvent = calendar.Event(
    title: event.title,
    description: event.description,
    location: getLocation(event.location),
    startDate: event.initialDate,
    endDate: event.finalDate,
  );
  calendar.Add2Calendar.addEvent2Cal(calendarEvent);
}

void call(Event event) async {
  if(event.phone.isNotEmpty){
    launch('tel:${event.phone.toString()}');
  }
}

void goToWebsite(Event event) async {
  if(event.site.isNotEmpty){
    if (await canLaunch(event.site)) {
      await launch(event.site);
    }
  }
}

void launchMapsUrl(Event event) async {
  Coordinates coordinates = Coordinates(latitude: getCoordinates(event.location)[0],
      longitude: getCoordinates(event.location)[1]);
  final url = 'https://www.google.com/maps/search/?api=1&query=${coordinates.latitude},'
      '${coordinates.longitude}';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
