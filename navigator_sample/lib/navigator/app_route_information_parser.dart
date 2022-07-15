import 'package:flutter/material.dart';
import 'package:navigator_sample/navigator/app_path.dart';

class AppRouteInformationParser extends RouteInformationParser<AppPathModel> {
  @override
  Future<AppPathModel> parseRouteInformation(
      RouteInformation routeInformation) async {
    return AppPathModel.getModel(routeInformation);
  }

  @override
  RouteInformation? restoreRouteInformation(AppPathModel configuration) {
    return configuration.getRouteInformation();
  }
}
