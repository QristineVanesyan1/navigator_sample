import 'package:flutter/material.dart';
import 'package:navigator_sample/models/topic_type.dart';
import 'package:navigator_sample/navigator/app_path.dart';
import 'package:navigator_sample/screens/error_screen.dart';
import 'package:navigator_sample/screens/home_screen.dart';
import 'package:navigator_sample/screens/details_screen.dart';
import 'package:navigator_sample/screens/info_screen.dart';
import 'package:navigator_sample/screens/topics_list_screen.dart';

class AppRouterDelegate extends RouterDelegate<AppPathModel>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  var currentPath = AppPathModel(path: null, isRoot: true);

  @override
  AppPathModel get currentConfiguration => currentPath;

  @override
  Widget build(BuildContext context) {
    List<Page> pages = _pages();

    return Navigator(
        key: navigatorKey, pages: pages, onPopPage: _handlePopPage);
  }

  List<Page<dynamic>> _pages() {
    var pages = <Page<dynamic>>[];
    if (currentConfiguration.isRoot == true) {
      pages.add(const MaterialPage<void>(child: HomeScreen()));
    } else if (currentConfiguration.isUnknown == true) {
      pages.add(const MaterialPage<void>(child: ErrorScreen()));
    } else {
      final segments = Uri.parse(currentConfiguration.path ?? '').pathSegments;
      if (segments.length == 2) {
        pages.add(MaterialPage<void>(
            child: DetailsScreen(
          id: segments[1],
          topicType: TopicType.getType(segments.first),
          reportJson: currentConfiguration.data as String?,
        )));
      } else if (segments.length == 1) {
        if (segments.first == 'info') {
          pages.add(const MaterialPage<void>(child: InfoScreen()));
          return pages;
        } else {
          pages.add(MaterialPage<void>(
              child: TopicsListScreen(
            topicType: TopicType.getType(segments.first),
          )));
        }
      }
    }
    return pages;
  }

  bool _handlePopPage(Route<dynamic> route, dynamic res) {
    Page page = route.settings as Page; //crash?
    if (page.key == ValueKey<String>('home')) {
      assert(!route.willHandlePopInternally);
      // Do not pop the home page.
      return false;
    }

    final bool result = route.didPop(res);
    // Update state to remove the page in question; if this modifies the state
    // it will call our listener, which will cause a rebuild.
    if (page.key == ValueKey<String>('search')) {
      // state.searchQuery = null;
      return true;
    }
    if (page.key == ValueKey<String>('details')) {
      // state.stockSymbol = null;
      return true;
    }
    return true;
  }

  @override
  Future<void> setNewRoutePath(AppPathModel configuration) async {
    currentPath = configuration;
    notifyListeners();
  }
}
