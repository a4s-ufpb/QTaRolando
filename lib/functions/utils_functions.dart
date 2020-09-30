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
  final eventoLocation = location.split(",");
  if (eventoLocation.length > 1) {
    return eventoLocation[0] + "," + eventoLocation[1];
  }
  return eventoLocation[0];
}

List<double> getCoodenadas(String location) {
  final eventoLocation = location.split(",");
  return [double.parse(eventoLocation[2]), double.parse(eventoLocation[3])];
}
