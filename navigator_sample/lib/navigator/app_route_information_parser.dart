import 'package:flutter/material.dart';
import 'package:navigator_sample/models/topic_type.dart';
import 'package:navigator_sample/navigator/app_path.dart';

class AppRouteInformationParser extends RouteInformationParser<AppPathModel> {
  @override
  Future<AppPathModel> parseRouteInformation(
      RouteInformation routeInformation) async {
    final Uri uri = Uri.parse(routeInformation.location ?? '');
    var count = uri.pathSegments.length;
    if (count == 0) {
      return AppPathModel(
          isRoot: true, path: null, data: routeInformation.state);
    } else if (count == 1) {
      if (_isCorrectCatalog(uri.pathSegments.first)) {
        return AppPathModel(path: routeInformation.location);
      }
    } else if (count == 2) {
      if (_isCorrectCatalog(uri.pathSegments.first) &&
          _hasMatch(uri.pathSegments.first, uri.pathSegments[1])) {
        return AppPathModel(path: routeInformation.location);
      }
    }
    return AppPathModel(isUnknown: true);
  }

  @override
  RouteInformation? restoreRouteInformation(AppPathModel configuration) {
    if (configuration.isRoot == true) {
      return RouteInformation(location: '/', state: configuration.data);
    } else if (configuration.isUnknown == true) {
      return RouteInformation(location: '/error404', state: configuration.data);
    } else {
      return RouteInformation(
          location: configuration.path, state: configuration.data);
    }
  }

  bool _isCorrectCatalog(String mainSegment) =>
      (mainSegment == TopicType.articles.name ||
          mainSegment == TopicType.reports.name ||
          mainSegment == TopicType.blogs.name);

  RegExp _getRegex(int count) => RegExp("^[0-9]{$count}\$");

  bool _hasMatch(String mainSegment, String id) {
    if (mainSegment == TopicType.articles.name) {
      return _getRegex(5).hasMatch(id);
    } else if (mainSegment == TopicType.reports.name) {
      return _getRegex(4).hasMatch(id);
    } else if (mainSegment == TopicType.blogs.name) {
      return _getRegex(3).hasMatch(id);
    } else {
      return false;
    }
  }
}
