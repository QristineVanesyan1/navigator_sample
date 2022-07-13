import 'package:flutter/material.dart';
import 'package:navigator_sample/constants/theme_params.dart';
import 'package:navigator_sample/navigator/app_route_information_parser.dart';
import 'package:navigator_sample/navigator/app_router_delegate.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      restorationScopeId: 'root',
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRouteInformationParser(),
      routerDelegate: AppRouterDelegate(),
      theme: ThemeParams.theme,
    );
  }
}
