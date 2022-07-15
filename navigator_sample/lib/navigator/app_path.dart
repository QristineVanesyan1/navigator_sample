import 'package:flutter/material.dart';

class AppPathModel implements RouteInformation {
  String? path;
  final bool? isUnknown;
  final bool? isRoot;
  final bool? isValid;
  final Object? data;

  factory AppPathModel.isRoot() {
    return AppPathModel(isRoot: true, path: '/');
  }

  factory AppPathModel.isValid(String path, Object? state) {
    return AppPathModel(isValid: true, path: path, data: state);
  }

  factory AppPathModel.isUnknown() {
    return AppPathModel(isUnknown: true, path: 'error404');
  }

  AppPathModel(
      {this.path,
      this.isUnknown = false,
      this.isRoot = false,
      this.data,
      this.isValid});

  @override
  String? get location => path;

  @override
  Object? get state => data;

// RouteInformation => AppPathModel
  static AppPathModel getModel(RouteInformation routeInformation) {
    final location = routeInformation.location;
    final state = routeInformation.state;
    if (location == null) {
      return AppPathModel.isRoot();
    } else {
      if (location.isEmpty) {
        return AppPathModel.isRoot();
      } else if (validateRoutes(location)) {
        return AppPathModel.isValid(location, state);
      } else {
        return AppPathModel.isUnknown();
      }
    }
  }

// AppPathModel => RouteInformation
  RouteInformation getRouteInformation() {
    return RouteInformation(location: path, state: data);
  }

  static bool validateRoutes(String url) {
    var regExpList = <RegExp>[
      RegExp(r"^(\/[a-z]+)$"), // /something
      RegExp(r"^(\/[a-z]+)(\/[0-9]+)$") // /something/1234
    ];
    for (RegExp regExp in regExpList) {
      if (regExp.hasMatch(url)) {
        return true;
      }
    }
    return false;
  }
}
