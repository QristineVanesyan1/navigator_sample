import 'package:flutter/material.dart';
import 'package:navigator_sample/navigator/app_params.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // title: 'Recognizer',//todo
        //todo: theme
        restorationScopeId: "something",
        routeInformationParser: AppParams.parser,
        routerDelegate: AppParams.delegate);
  }
}
