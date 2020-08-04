class Evento {
  final String imagePath,
      title,
      description,
      location,
      initialDate,
      finalDate,
      site,
      punchLine1,
      punchLine2,
      phone;
  final List categoryIds, galleryImages;

  Evento({
    this.imagePath,
    this.title,
    this.description,
    this.location,
    this.initialDate,
    this.finalDate,
    this.site,
    this.punchLine1,
    this.punchLine2,
    this.phone,
    this.categoryIds,
    this.galleryImages,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      categoryIds: [0, json["categoryId"]],
      description: json["description"] as String,
      initialDate: json["initialDate"] as String,
      finalDate: json["finalDate"] as String,
      imagePath: json["imagePath"] as String,
      location: json["location"] as String,
      punchLine1: json["punchLine1"] as String,
      punchLine2: json["punchLine2"] as String,
      title: json["title"] as String,
      site: json["site"] as String,
      phone: json["phone"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "categoryId": categoryIds[1] as int,
        "description": description,
        "initialDate": initialDate,
        "finalDate": finalDate,
        "imagePath": imagePath,
        "location": location,
        "punchLine1": punchLine1,
        "punchLine2": punchLine2,
        "title": title,
        "site": site,
        "phone": phone,
      };

  static List<Evento> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((evento) => Evento.fromJson(evento)).toList();
  }
}
