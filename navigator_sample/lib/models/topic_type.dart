import 'package:navigator_sample/constants/constants.dart';

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

  String getEndPoint() {
    switch (this) {
      case TopicType.articles:
        return '${Constants.baseEndPoint}articles';
      case TopicType.reports:
        return "${Constants.baseEndPoint}reports";
      case TopicType.blogs:
        return "${Constants.baseEndPoint}blogs";
      default:
        return "";
    }
  }

  String getDocLink() {
    switch (this) {
      case TopicType.articles:
        return '${Constants.baseEndPoint}documentation#/Article';
      case TopicType.reports:
        return "${Constants.baseEndPoint}documentation#/Report";
      case TopicType.blogs:
        return "${Constants.baseEndPoint}documentation#/Blog";
      default:
        return "";
    }
  }

  String getImage() {
    switch (this) {
      case TopicType.articles:
        return "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/static/home/thespacedevs/images/snapifeatures/news.jpg";
      case TopicType.reports:
        return "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/static/home/thespacedevs/images/snapifeatures/reports.jpg";
      case TopicType.blogs:
        return "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/static/home/thespacedevs/images/snapifeatures/blogs.jpg";
      default:
        return "";
    }
  }

  @override
  String toString() => fullName;
}
