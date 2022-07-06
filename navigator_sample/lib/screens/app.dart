import 'package:flutter/material.dart';
import 'package:navigator_sample/constants/app_params.dart';
import 'package:navigator_sample/constants/theme_params.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // title: 'Recognizer',//todo
      restorationScopeId: "something",
      routeInformationParser: AppParams.parser,
      routerDelegate: AppParams.delegate,
      theme: ThemeParams.theme,
    );
  }
}
