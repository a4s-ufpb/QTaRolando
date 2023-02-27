import 'package:flutter/material.dart';
import 'package:local_events/widgets/event_widget.dart';

void filterHojeEAmanha(EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.event.initialDate.day ==
          DateTime.now().day && eventWidget.event.initialDate.month ==
          DateTime.now().month && eventWidget.event.initialDate.year ==
          DateTime.now().year &&
      eventWidget.event.location == "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterHojeEPresencial(
    EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.event.initialDate.day ==
          DateTime.now().day && eventWidget.event.initialDate.month ==
          DateTime.now().month && eventWidget.event.initialDate.year ==
          DateTime.now().year &&
      eventWidget.event.location != "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterHoje(EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.event.initialDate.day ==
          DateTime.now().day && eventWidget.event.initialDate.month ==
          DateTime.now().month && eventWidget.event.initialDate.year ==
          DateTime.now().year) {
    filterByFilters.add(eventWidget);
  }
}

void filterEsteMesEOnline(
    EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.event.initialDate.month ==
          DateTime.now().month && eventWidget.event.initialDate.year ==
          DateTime.now().year &&
      eventWidget.event.location == "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterEsteMesEPresencial(
    EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.event.initialDate.month ==
          DateTime.now().month && eventWidget.event.initialDate.year ==
          DateTime.now().year &&
      eventWidget.event.location != "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterEsteMes(EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.event.initialDate.month ==
          DateTime.now().month && eventWidget.event.initialDate.year ==
          DateTime.now().year) {
    filterByFilters.add(eventWidget);
  }
}

void filterProxMesEOnline(
    EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.event.initialDate.month ==
          DateTime.now().month + 1 && eventWidget.event.initialDate.year ==
          DateTime.now().year &&
      eventWidget.event.location == "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterProxMesEPresencial(
    EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.event.initialDate.month ==
          DateTime.now().month + 1 && eventWidget.event.initialDate.year ==
          DateTime.now().year &&
      eventWidget.event.location != "Online") {
    filterByFilters.add(eventWidget);
  }
}

void filterProxMes(EventWidget eventWidget, List<Widget> filterByFilters) {
  if (eventWidget.event.initialDate.month ==
          DateTime.now().month + 1 && eventWidget.event.initialDate.year ==
          DateTime.now().year) {
    filterByFilters.add(eventWidget);
  }
}
