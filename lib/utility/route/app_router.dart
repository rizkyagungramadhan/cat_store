import 'package:cat_store/utility/route/app_route.dart';
import 'package:cat_store/utility/route/route_definition.dart';
import 'package:cat_store/utility/route/route_info.dart';
import 'package:flutter/material.dart';

typedef RouteBuilder = Widget Function(
  BuildContext context,
  RouteInfo information,
);

class AppRouter {
  GlobalKey<NavigatorState> rootNavigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> bottomNavigationKey = GlobalKey<NavigatorState>();

  // RouteObserver<ModalRoute> rootNavRouteObserver = RouteObserver();
  // RouteObserver<ModalRoute> bottomNavRouteObserver = RouteObserver();

  final Map<RouteDefinition, RouteBuilder> _routerRegistry = {};

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final route = findRouteFromSetting(settings);
    if (route != null) {
      return MaterialPageRoute(
        builder: (context) {
          return _routerRegistry[route]?.call(
                context,
                RouteInfo(argument: settings.arguments),
              ) ??
              const SizedBox.shrink();
        },
        settings: settings,
      );
    }
    return null;
  }

  RouteDefinition? findRouteFromSetting(RouteSettings? settings) {
    if (settings == null) return null;
    for (var route in _routerRegistry.keys) {
      if (isRouteMatchFromSetting(route, settings)) {
        return route;
      }
    }
    return null;
  }

  bool isRouteMatchFromSetting(RouteDefinition route, RouteSettings settings) {
    return route.name == settings.name;
  }

  String? getActiveRouteName() {
    final route = getActiveRoute();
    return findRouteFromSetting(route?.settings)?.name ?? route?.settings.name;
  }

  Route<dynamic>? getActiveRoute() {
    final rootRoute = getCurrentRootRoute();
    final bottomRoute = getCurrentBottomRoute();

    // Is in main screen
    if (findRouteFromSetting(rootRoute?.settings)?.name == Routes.home.name) {
      // return active bottom route
      return bottomRoute;
    } else {
      // return active root route
      return rootRoute;
    }
  }

  Route<dynamic>? getCurrentBottomRoute() {
    Route<dynamic>? currentRoute;
    bottomNavigationKey.currentState?.popUntil((route) {
      currentRoute = route;
      return true;
    });
    return currentRoute;
  }

  Route<dynamic>? getCurrentRootRoute() {
    Route<dynamic>? currentRoute;
    rootNavigationKey.currentState?.popUntil((route) {
      currentRoute = route;
      return true;
    });
    return currentRoute;
  }

  List<Route<dynamic>> generateInitialRoute(
    String initialRoute, {
    Object? arguments,
  }) {
    final settings = RouteSettings(name: initialRoute, arguments: arguments);
    final route = generateRoute(settings);

    if (route == null) return [];
    return [route];
  }

  void registerRoute(RouteDefinition routeDefinition, RouteBuilder builder) {
    _routerRegistry[routeDefinition] = builder;
  }

  Future<dynamic> rootNavigateTo(RouteDefinition route, [dynamic args]) {
    return rootNavigationKey.currentState!
        .pushNamed(route.name, arguments: args);
  }

  Future<dynamic> rootClearAndNavigateTo(RouteDefinition route,
      [dynamic args]) {
    return rootNavigationKey.currentState!.pushNamedAndRemoveUntil(
      route.name,
      ((Route<dynamic> route) => false),
      arguments: args,
    );
  }

  Future<dynamic> bottomNavigateReplaceTo(RouteDefinition route,
      [dynamic args]) {
    return bottomNavigationKey.currentState!
        .pushReplacementNamed(route.name, arguments: args);
  }

  Future<dynamic> bottomNavigateTo(RouteDefinition route, [dynamic args]) {
    return bottomNavigationKey.currentState!
        .pushNamed(route.name, arguments: args);
  }

  void rootGoBack() {
    return rootNavigationKey.currentState?.pop();
  }

  void rootGoBackToRoot() {
    rootNavigationKey.currentState!.popUntil(
      ModalRoute.withName(Routes.home.name),
    );
  }
}
