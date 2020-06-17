class Event {
  final String imagePath,
      title,
      description,
      location,
      duration,
      punchLine1,
      punchLine2;
  final List categoryIds, galleryImages;

  Event({
    this.imagePath,
    this.title,
    this.description,
    this.location,
    this.duration,
    this.punchLine1,
    this.punchLine2,
    this.categoryIds,
    this.galleryImages,
  });
}

final fivekmRunEvent = Event(
  imagePath: "",
  title: "fivekmRunEvent",
  description: "Local com a descrição do evento para o usuário.",
  duration: "3h",
  location: "fivekmRunEvent",
  punchLine1: "Frase! ",
  punchLine2: "Que resume o evento",
  categoryIds: [0, 1],
);

final coockingEvent = Event(
  imagePath: "",
  title: "coockingEvent",
  description: "Local com a descrição do evento para o usuário.",
  duration: "3h",
  location: "coockingEvent",
  punchLine1: "Frase! ",
  punchLine2: "Que resume o evento",
  categoryIds: [0, 2],
);

final musicEvent = Event(
  imagePath: "",
  title: "musicEvent",
  description: "Local com a descrição do evento para o usuário.",
  duration: "3h",
  location: "musicEvent",
  punchLine1: "Frase! ",
  punchLine2: "Que resume o evento",
  categoryIds: [0, 1],
);

final golfCompetition = Event(
  imagePath: "",
  title: "golfCompetition",
  description: "Local com a descrição do evento para o usuário.",
  duration: "3h",
  location: "golfCompetition",
  punchLine1: "Frase! ",
  punchLine2: "Que resume o evento",
  categoryIds: [0, 2],
);

final events = [
  fivekmRunEvent,
  coockingEvent,
  musicEvent,
  golfCompetition,
];
