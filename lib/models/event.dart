import 'package:local_events/models/coordinates.dart';

class Event {
  final int id;
  final String title;
  final String subtitle;
  final List categoriesIds;
  final String description;
  final DateTime initialDate;
  final DateTime finalDate;
  final String imagePath;
  final String location;
  final Coordinates coordinates;
  final String phone;
  final String site;

  Event(
      {this.id,
      this.title,
      this.subtitle,
      this.categoriesIds,
      this.description,
      this.initialDate,
      this.finalDate,
      this.imagePath,
      this.location,
      this.coordinates,
      this.phone,
      this.site});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json["title"] as String,
      subtitle: json["subtitle"] as String,
      categoriesIds: [0, json["categories"]],
      description: json["description"] as String,
      initialDate: DateTime.parse(json["initialDate"]),
      finalDate: DateTime.parse(json["finalDate"]),
      imagePath: json["imagePath"] as String,
      location: json["location"] as String,
      coordinates: Coordinates(
        latitude: 0,
        longitude: 0,
      ),
      phone: json["phone"] as String,
      site: json["site"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "categories": categoriesIds,
        "description": description,
        "initialDate": initialDate,
        "finalDate": finalDate,
        "imagePath": imagePath,
        "location": location,
        "phone": phone,
        "site": site,
      };

  static List<Event> fromJsonList(List list) {
    if (list == null) return null;

    return list.map((evento) => Event.fromJson(evento)).toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
