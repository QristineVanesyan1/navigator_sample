import 'package:flutter/material.dart';
import 'package:navigator_sample/navigator/app_path.dart';

class AppRouteInformationParser extends RouteInformationParser<AppPathModel> {
  //RouteInformation -> state?
  @override
  Future<AppPathModel> parseRouteInformation(
      RouteInformation routeInformation) async {
    final Uri uri = Uri.parse(routeInformation.location ?? '');
    var count = uri.pathSegments.length;
    if (count == 0) {
      return AppPathModel(isRoot: true, path: null);
    } else if (count == 1 || count == 2) {
      String url = '';
      for (int i = 0; i < count; i++) {
        url += "/${uri.pathSegments[i]}";
      }
      return AppPathModel(path: url);
    } else {
      return AppPathModel(isUnknown: true);
    }
  }

// this method responsible for URL
  @override
  RouteInformation? restoreRouteInformation(AppPathModel configuration) {
    if (configuration.isRoot == true) {
      return const RouteInformation(location: '/');
    } else if (configuration.isUnknown == true) {
      return const RouteInformation(location: '/error404');
    } else {
      print(configuration.path);
      return RouteInformation(location: configuration.path);
    }
  }
}
