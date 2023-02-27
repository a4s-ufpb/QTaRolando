import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:local_events/models/event.dart';

class EventServices {
  int totalPages;
  bool isLast;

  Future<List<Event>> getEventsFiltered({
    String title = "",
    int categoryId = 0,
    String modality,
    String dateType,
    DateTime initialDate,
    DateTime finalDate,
    int page,
    int pageSize = 10}) async {
    final dio = Dio();
    final apiUrl = dotenv.get('API_URL', fallback: 'API_URL not found');
    final url = "$apiUrl/events/filter";
    final queryParams = {
      "title": title,
      "categoryId": categoryId != 0 ? categoryId : null,
      "modality": modality,
      "dateType": dateType,
      "initialDate": initialDate,
      "finalDate": finalDate,
      "page": page,
      "pageSize": pageSize
    };
    final response = await dio.get(url, queryParameters: queryParams);
    this.totalPages = response.data['totalPages'];
    this.isLast = response.data['last'];

    if(response.statusCode == 200) {
      return Event.fromJsonList(response.data['content']);
    } else {
      print('Unexpected response');
      return [];
    }
  }
}
