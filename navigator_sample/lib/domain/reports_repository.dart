import 'package:http/http.dart' as http;
import 'package:navigator_sample/constants/constants.dart';
import 'package:navigator_sample/models/topic_type.dart';
import 'package:navigator_sample/models/info.dart';
import 'package:navigator_sample/models/report.dart';
import 'dart:convert';

class ReportsRepository {
  Future<List<Report>> fetchData(TopicType topicType) async {
    String link = '${Constants.baseEndPoint}${topicType.name}';

    var response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      var responseBody = response.bodyBytes;
      String jsonStr = String.fromCharCodes(responseBody);
      var jsonResponse = json.decode(jsonStr);
      return jsonResponse.map<Report>((json) => Report.fromJson(json)).toList();
    }
    throw Exception();
  }

  Future<Info> fetchInfo() async {
    {
      var catalog = 'info';
      final endpoint = '${Constants.baseEndPoint}$catalog';

      var response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        var responseBody = response.bodyBytes;
        String body = String.fromCharCodes(responseBody);
        var jsonResponse = json.decode(body);
        return Info.fromJson(jsonResponse);
      }
      throw Exception();
    }
  }

  Future<Report?> getReport(TopicType topicType, String id) async {
    if (id == '') {
      return null;
    }
    final endpoint = '${Constants.baseEndPoint}${topicType.name}/$id';
    var response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      var responseBody = response.bodyBytes;
      String body = String.fromCharCodes(responseBody);
      var jsonResponse = json.decode(body);
      return Report.fromJson(jsonResponse);
    }
    throw Exception();
  }
}
