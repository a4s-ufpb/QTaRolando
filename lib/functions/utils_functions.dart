import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_events/models/coordinates.dart';

String capitalize(String string) {
  if (string == null) {
    throw ArgumentError("string: $string");
  }

  if (string.isEmpty) {
    return string;
  }

  return "${string[0].toUpperCase()}${string.substring(1)}";
}

String getLocation(String location) {
  final eventLocation = location.split("@");
  if(eventLocation.equals(["remote"])) {
    return 'Remoto';
  } else {
    return "Presencial";
  }
}

List<double> getCoordinates(String location) {
  var coordinates = Coordinates();

  final regex = RegExp(r'@-?\d+\.\d+,-?\d+\.\d+\b');
  final match = regex.firstMatch(location);

  if (match != null) {
    final coordinatesString = match.group(0).replaceAll("@", "").split(",");
    coordinates = Coordinates(
      latitude: double.parse(coordinatesString[0]),
      longitude: double.parse(coordinatesString[1]),
    );
  } else {
    coordinates = Coordinates(
      latitude: 0,
      longitude: 0,
    );
  }


  return [coordinates.latitude, coordinates.longitude];
}

Uint8List imageToBytes(String imageUrl) {
  final bytes = base64.decode(imageUrl.replaceFirst(RegExp('data:image\\/.*;base64,'), ''));
  return bytes.buffer.asUint8List();
}
