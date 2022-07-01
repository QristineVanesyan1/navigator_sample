import 'package:navigator_sample/navigator/app_route_information_parser.dart';
import 'package:navigator_sample/navigator/app_router_delegate.dart';

class AppParams {
  static final parser = AppRouteInformationParser();
  static final delegate = AppRouterDelegate();
}
