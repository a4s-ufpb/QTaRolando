class Filter {
  final String name;
  final String type;
  Filter({
    this.name,
    this.type,
  });
}

final List<Filter> filtersByDate = [
  hoje,
  esteMes,
  proxMes,
];

final List<Filter> filtersByType = [
  online,
  presencial,
];

final hoje = Filter(name: "Hoje", type: "date");
final esteMes = Filter(name: "Este mês", type: "date");
final proxMes = Filter(name: "Próx. mês", type: "date");

final online = Filter(name: "Online", type: "type");
final presencial = Filter(name: "Presencial", type: "type");
