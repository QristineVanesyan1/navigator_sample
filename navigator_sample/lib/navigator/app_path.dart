import 'package:flutter/material.dart';

class AppPathModel implements RouteInformation {
  String? path;
  final bool? isUnknown;
  final bool? isRoot;
  final Object? data;

  AppPathModel(
      {this.path, this.isUnknown = false, this.isRoot = false, this.data});

  @override
  String? get location => path;

  @override
  Object? get state => data;
}
