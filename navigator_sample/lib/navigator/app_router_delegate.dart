import 'package:flutter/material.dart';
import 'package:navigator_sample/navigator/app_path.dart';
import 'package:navigator_sample/models/topic_type.dart';
import 'package:navigator_sample/screens/error_screen.dart';
import 'package:navigator_sample/screens/home_screen.dart';
import 'package:navigator_sample/screens/details_screen.dart';
import 'package:navigator_sample/screens/info_screen.dart';
import 'package:navigator_sample/screens/topics_list_screen.dart';

//setInitialRoutePath
//setRestoredRoutePath
//setNewRoutePath
//popRoute
//currentConfiguration
//build
class AppRouterDelegate extends RouterDelegate<AppPathModel>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  var currentPath = AppPathModel(path: null, isRoot: true);
  // this one is responsible for URL
  @override
  AppPathModel get currentConfiguration => currentPath;

  @override
  Widget build(BuildContext context) {
    List<Page> pages = _pages();
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: _onPopPage,
      onGenerateRoute: null,
    );
  }

  bool _isCorrectCatalog(String catalog) =>
      (catalog == TopicType.articles.name ||
          catalog == TopicType.reports.name ||
          catalog == TopicType.blogs.name);

  bool _isCorrectId(String catalog) => true;

  List<Page<dynamic>> _pages() {
    var pages = <Page<dynamic>>[];
    if (currentConfiguration.isRoot == true) {
      pages.add(const MaterialPage<void>(child: HomeScreen()));
      return pages;
    } else {
      final segments = Uri.parse(currentConfiguration.path ?? '').pathSegments;
      if (segments.length == 2) {
        if (_isCorrectCatalog(segments.first)) {
          if (_isCorrectId(segments[1])) {
            pages.add(MaterialPage<void>(
                child: DetailsScreen(
              id: segments[1],
              valueKey: ValueKey(segments.first.toString()),
              reportJson: currentConfiguration.data as String?,
            )));
            return pages;
          } else {
            pages.add(const MaterialPage<void>(child: ErrorScreen()));
            return pages;
          }
        } else {
          pages.add(const MaterialPage<void>(child: ErrorScreen()));
          return pages;
        }
      } else if (segments.length == 1) {
        if (segments.first == 'info') {
          pages.add(const MaterialPage<void>(child: InfoScreen()));
          return pages;
        } else if (segments.first == TopicType.articles.name ||
            segments.first == TopicType.reports.name ||
            segments.first == TopicType.blogs.name) {
          pages.add(MaterialPage<void>(
              child: TopicsListScreen(
            valueKey: ValueKey(segments.first),
          )));
          return pages;
        }
      }
    }
    pages.add(const MaterialPage<void>(child: ErrorScreen()));
    return pages;
  }

  bool _onPopPage(Route route, dynamic result) {
    debugPrint('onPopPage: $result');
    if (!route.didPop(result)) {
      return false;
    }
    if (currentPath.isRoot != true) {
      final location = currentPath.path;
      if (location?.lastIndexOf('/') != -1) {
        final path = location?.substring(0, location.lastIndexOf('/'));
        if (path == '') {
          setNewRoutePath(AppPathModel(isRoot: true));
        } else {
          setNewRoutePath(AppPathModel(isRoot: false, path: path));
        }
        return true;
      } else {
        setNewRoutePath(AppPathModel(isRoot: true));
        return true;
      }
    }
    return false;
  }

  @override
  Future<void> setNewRoutePath(AppPathModel configuration) async {
    currentPath = configuration;
    notifyListeners();
  }

  @override
  Future<void> setRestoredRoutePath(AppPathModel configuration) {
    // TODO: implement setRestoredRoutePath
    return super.setRestoredRoutePath(configuration);
  }

  @override
  Future<void> setInitialRoutePath(AppPathModel configuration) {
    // TODO: implement setInitialRoutePath
    return super.setInitialRoutePath(configuration);
  }

  @override
  Future<bool> popRoute() {
    // TODO: implement popRoute
    return super.popRoute();
  }
}
