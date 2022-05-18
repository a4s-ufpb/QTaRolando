import 'dart:convert';

import 'package:local_events/models/event.dart';

import 'package:http/http.dart' as http;

class Services {
  static const ROOT = 'php file address of your mysql database';
  static const _GET_ALL_ACTION = 'GET_ALL';

  static Future<List<Evento>> getEventos() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      if (response.statusCode == 200) {
        List<Evento> list = parseResponse(response.body);
        return list;
      } else {
        return List<Evento>();
      }
    } catch (e) {
      return List<Evento>();
    }
  }

  static List<Evento> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Evento>((json) => Evento.fromJson(json)).toList();
  }
}
