class Filter {
  final String name;
  final String type;
  Filter({
    this.name,
    this.type,
  });
}

final List<Filter> filtersByDate = [
  HOJE,
  AMANHA,
  ESTA_SEMANA,
  FIM_SEMANA,
  PROX_SEMANA,
  ESTE_MES,
];

final List<Filter> filtersByType = [
  online,
  presencial,
];

final HOJE = Filter(name: "Hoje", type: "date");
final AMANHA = Filter(name: "Amanhã", type: "date");
final ESTA_SEMANA = Filter(name: "Esta Semana", type: "date");
final FIM_SEMANA = Filter(name: "Este Fim de Semana", type: "date");
final PROX_SEMANA = Filter(name: "Proxima Semana", type: "date");
final ESTE_MES = Filter(name: "Este Mês", type: "date");

final online = Filter(name: "Online", type: "type");
final presencial = Filter(name: "Presencial", type: "type");
