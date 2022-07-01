import 'package:flutter/material.dart';

enum TopicType {
  articles("Articles"),
  blogs('Blogs'),
  reports('Reports');

  const TopicType(this.fullName);
  final String fullName;

  static TopicType getType(String shortName) {
    switch (shortName) {
      case 'articles':
        return TopicType.articles;
      case 'reports':
        return TopicType.reports;
      case 'blogs':
        return TopicType.blogs;
      default:
        return TopicType.blogs;
    }
  }

  String getDesc() {
    switch (this) {
      case TopicType.articles:
        return "Retrieves a list of articles. You can query this endpoint with parameter 'news_site' to return articles provided by a particular news site. This endpoint can also be queried with 'search' to search for articles which match your search parameter.";
      case TopicType.blogs:
        return "Retrieves a list of blogs. You can query this endpoint with parameter 'news_site' to return blogs provided by a particular news site. This endpoint can also be queried with 'search' to search for blogs which match your search parameter";
      case TopicType.reports:
        return "Retrieves a list of reports (like ISS daily reports). You can query this endpoint with parameter 'news_site' to return reports provided by a particular news site. This endpoint can also be queried with 'search' to search for reports which match your search parameter.";
      default:
        return '';
    }
  }

  String getTitle() {
    switch (this) {
      case TopicType.articles:
        return 'News Articles';
      case TopicType.blogs:
        return 'Blogs';
      case TopicType.reports:
        return 'Reports';
      default:
        return '';
    }
  }

  Widget getIcon() {
    switch (this) {
      case TopicType.articles:
        return const Icon(Icons.article);
      case TopicType.blogs:
        return const Icon(Icons.info);
      default:
        return const Icon(Icons.report);
    }
  }

  String getEndPoint() {
    switch (this) {
      case TopicType.articles:
        return 'https://api.spaceflightnewsapi.net/v3/articles';
      case TopicType.reports:
        return "https://api.spaceflightnewsapi.net/v3/reports";
      case TopicType.blogs:
        return "https://api.spaceflightnewsapi.net/v3/blogs";
      default:
        return "";
    }
  }

  String getDocLink() {
    switch (this) {
      case TopicType.articles:
        return 'https://api.spaceflightnewsapi.net/v3/documentation#/Article';
      case TopicType.reports:
        return "https://api.spaceflightnewsapi.net/v3/documentation#/Report";
      case TopicType.blogs:
        return "https://api.spaceflightnewsapi.net/v3/documentation#/Blog";
      default:
        return "";
    }
  }

  @override
  String toString() => fullName;
}
