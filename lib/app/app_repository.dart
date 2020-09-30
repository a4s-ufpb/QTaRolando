import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:intl/intl.dart';
import 'package:local_events/models/event.dart';

class AppRepository extends Disposable {
  final HasuraConnect connection;

  AppRepository(this.connection);

  Future<List<Evento>> getEventos() async {
    var query = """
      subscription {
        eventos(order_by: {initialDate: asc}) {
          categoryId
          description
          initialDate
          finalDate
          imagePath
          location
          punchLine1
          punchLine2
          title
          site
          phone
        }
      }
      """;
    var jsonList = await connection.query(query);
    var eventos = Evento.fromJsonList(jsonList["data"]["eventos"]);
    print(eventos);
    return eventos;
  }

  Stream<List<Evento>> getEventosStream() {
    var query = """
      subscription {
        eventos(order_by: {initialDate: asc}) {
          categoryId
          description
          initialDate
          finalDate
          imagePath
          location
          punchLine1
          punchLine2
          title
          site
          phone
        }
      }
      """;
    Snapshot snapshot = connection.subscription(query);
    return snapshot.stream
        .map((jsonList) => Evento.fromJsonList(jsonList["data"]["eventos"]));
  }

  Stream<List<Evento>> getEventosHoje() {
    String dataAtual = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var query = """
    subscription {
      eventos(where: {initialDate: {_eq: "$dataAtual"}}) {
        categoryId
        description
        finalDate
        imagePath
        initialDate
        location
        phone
        punchLine1
        punchLine2
        site
        title
      }
    }
    """;
    Snapshot snapshot = connection.subscription(query);
    return snapshot.stream
        .map((jsonList) => Evento.fromJsonList(jsonList["data"]["eventos"]));
  }

  @override
  void dispose() {
    connection.dispose();
  }
}
