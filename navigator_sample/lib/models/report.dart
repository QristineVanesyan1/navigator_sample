class Report {
  final int id;
  final String title;
  final String url;
  final String imageUrl;
  final String newsSite;
  final String summary;
  final String publishedAt;

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
        publishedAt: json['publishedAt']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['imageUrl'] = imageUrl;
    data['newsSite'] = newsSite;
    data['summary'] = summary;
    data['publishedAt'] = publishedAt;
    return data;
  }
}