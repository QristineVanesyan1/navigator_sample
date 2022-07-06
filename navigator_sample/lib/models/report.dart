import 'dart:convert';

class Report {
  final int id;
  final String title;
  final String url;
  final String imageUrl;
  final String newsSite;
  final String summary;
  final DateTime publishedAt;

  Report(
      {required this.id,
      required this.title,
      required this.url,
      required this.imageUrl,
      required this.newsSite,
      required this.summary,
      required this.publishedAt});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        imageUrl: json['imageUrl'],
        newsSite: json['newsSite'],
        summary: json['summary'],
        publishedAt: DateTime.parse(json['publishedAt']));
  }

  static Map<String, dynamic> toJsonListOfReports(List<Report> reports) {
    final result = <String, dynamic>{};
    for (int i = 0; i < reports.length; i++) {
      final report = reports[i];
      final data = <String, dynamic>{};
      data['id'] = report.id;
      data['title'] = report.title;
      data['url'] = report.url;
      data['imageUrl'] = report.imageUrl;
      data['newsSite'] = report.newsSite;
      data['summary'] = report.summary;
      data['publishedAt'] = report.publishedAt;
      result[i.toString()] = data;
    }
    return result;
  }

  String toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['imageUrl'] = imageUrl;
    data['newsSite'] = newsSite;
    data['summary'] = summary;
    data['publishedAt'] = publishedAt.toIso8601String();
    return json.encode(data);
  }
}
