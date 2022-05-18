class Evento {
  final int id;
  final String title;
  final String subtitle;
  final int categoryId;
  final String description;
  final DateTime initialDate;
  final DateTime finalDate;
  final String imagePath;
  final String location;
  final String phone;
  final String site;
  final List categoryIds, galleryImages;

  Evento(
      {this.id,
      this.title,
      this.subtitle,
      this.categoryId,
      this.description,
      this.initialDate,
      this.finalDate,
      this.imagePath,
      this.location,
      this.phone,
      this.site,
      this.categoryIds,
      this.galleryImages});

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      title: json["title"] as String,
      subtitle: json["subtitle"] as String,
      categoryIds: [0, json["categoryId"]],
      description: json["description"] as String,
      initialDate: DateTime.parse(json["initialDate"]),
      finalDate: DateTime.parse(json["finalDate"]),
      imagePath: json["imagePath"] as String,
      location: json["location"] as String,
      phone: json["phone"] as String,
      site: json["site"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "categoryId": categoryIds[1] as int,
        "description": description,
        "initialDate": initialDate,
        "finalDate": finalDate,
        "imagePath": imagePath,
        "location": location,
        "phone": phone,
        "site": site,
      };

  static List<Evento> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((evento) => Evento.fromJson(evento)).toList();
  }
}
