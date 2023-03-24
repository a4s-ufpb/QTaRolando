import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
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

  if(location == "remote"){
    coordinates = Coordinates(
      latitude: 0,
      longitude: 0,
    );
  } else {
    final regex = RegExp(r'@-?\d+\.\d+,-?\d+\.\d+\b');
    final match = regex.firstMatch(location);
    final coordinatesString = match.group(0).replaceAll("@", "").split(",");

    coordinates = Coordinates(
      latitude: double.parse(coordinatesString[0]),
      longitude: double.parse(coordinatesString[1]),
    );
  }

  return [coordinates.latitude, coordinates.longitude];
}

Future<String> imageToBase64(File imageFile) async {
  List<int> imageBytes = await imageFile.readAsBytes();
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}

