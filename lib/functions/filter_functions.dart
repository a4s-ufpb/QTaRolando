import 'package:flutter/material.dart';
import 'package:local_events/widgets/event_widget.dart';

void filterHojeEAmanha(EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.evento.initialDate.day ==
          DateTime.now().day && eventWidget.evento.initialDate.month ==
          DateTime.now().month && eventWidget.evento.initialDate.year ==
          DateTime.now().year &&
      eventWidget.evento.location == "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterHojeEPresencial(
    EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.evento.initialDate.day ==
          DateTime.now().day && eventWidget.evento.initialDate.month ==
          DateTime.now().month && eventWidget.evento.initialDate.year ==
          DateTime.now().year &&
      eventWidget.evento.location != "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterHoje(EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.evento.initialDate.day ==
          DateTime.now().day && eventWidget.evento.initialDate.month ==
          DateTime.now().month && eventWidget.evento.initialDate.year ==
          DateTime.now().year) {
    filterByFilters.add(eventWidget);
  }
}

void filterEsteMesEOnline(
    EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.evento.initialDate.month ==
          DateTime.now().month && eventWidget.evento.initialDate.year ==
          DateTime.now().year &&
      eventWidget.evento.location == "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterEsteMesEPresencial(
    EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.evento.initialDate.month ==
          DateTime.now().month && eventWidget.evento.initialDate.year ==
          DateTime.now().year &&
      eventWidget.evento.location != "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterEsteMes(EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.evento.initialDate.month ==
          DateTime.now().month && eventWidget.evento.initialDate.year ==
          DateTime.now().year) {
    filterByFilters.add(eventWidget);
  }
}

void filterProxMesEOnline(
    EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.evento.initialDate.month ==
          DateTime.now().month + 1 && eventWidget.evento.initialDate.year ==
          DateTime.now().year &&
      eventWidget.evento.location == "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterProxMesEPresencial(
    EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.evento.initialDate.month ==
          DateTime.now().month + 1 && eventWidget.evento.initialDate.year ==
          DateTime.now().year &&
      eventWidget.evento.location != "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterProxMes(EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.evento.initialDate.month ==
          DateTime.now().month + 1 && eventWidget.evento.initialDate.year ==
          DateTime.now().year) {
    filterByFilters.add(eventWidget);
  }
}
