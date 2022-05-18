import 'package:local_events/models/event.dart';
import 'package:dio/dio.dart';

class AppRepository{

  Future<List<Evento>> getEventos() async {
    Dio dio = new Dio();
    
    var response = await dio.get("{QTAROLANDO API URL}/api/events");
    dio.close(force: true);
    List<Evento> listaEventos = Evento.fromJsonList(response.data) ;

    return listaEventos;
  }
}
