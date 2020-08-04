import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:local_events/models/event.dart';

class AppRepository extends Disposable {
  final HasuraConnect connection;

  AppRepository(this.connection);

  Future<List<Evento>> getEventos() async {
    var query = """
      subscription {
        eventos(order_by: {id: desc}) {
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
        eventos(order_by: {id: desc}) {
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

  @override
  void dispose() {
    connection.dispose();
  }
}
