import 'package:flutter/material.dart';
import 'package:navigator_sample/locator.dart';
import 'package:navigator_sample/screens/app.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  setup();
  runApp(const App());
}
