import 'package:local_events/models/event.dart';
import 'package:dio/dio.dart';

class AppRepository{

  Future<List<Evento>> getEventos() async {
    Dio dio = new Dio();
    
    var response = await dio.get("https://qtarolando-api.herokuapp.com/api/listar-todos");
    dio.close(force: true);
    List<Evento> listaEventos = Evento.fromJsonList(response.data) ;

    return listaEventos;
  }
}
