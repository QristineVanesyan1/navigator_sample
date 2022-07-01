import 'package:http/http.dart' as http;
import 'package:navigator_sample/data/topic_type.dart';
import 'package:navigator_sample/models/info.dart';
import 'package:navigator_sample/models/report.dart';
import 'dart:convert';

class DataSource {
  static String get endPointBaseUrl => 'https://api.spaceflightnewsapi.net/v3/';

  Future<List<Report>> fetchData(TopicType topicType) async {
    String link = '';
    link = '$endPointBaseUrl${topicType.toString()}';

    var response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      var responseBody = response.bodyBytes;
      String jsonStr = String.fromCharCodes(responseBody);
      var jsonResponse = json.decode(jsonStr);
      return jsonResponse.map<Report>((json) => Report.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<Info> fetchInfo() async {
    {
      var catalog = 'info';
      final endpoint = '$endPointBaseUrl$catalog';
      var response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        var responseBody = response.bodyBytes;
        String body = String.fromCharCodes(responseBody);
        var jsonResponse = json.decode(body);
        return Info.fromJson(jsonResponse);
      }
      throw Exception("Something went wrong");
    }
  }

  Future<Report?> getReport(String topicType, String id) async {
    if (id == '') {
      return null;
    }
    final endpoint = 'https://api.spaceflightnewsapi.net/v3/$topicType/$id';
    var response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      var responseBody = response.bodyBytes;
      String body = String.fromCharCodes(responseBody);
      var jsonResponse = json.decode(body);
      return Report.fromJson(jsonResponse);
    }
    return null;
  }
}
