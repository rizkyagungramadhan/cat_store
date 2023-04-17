import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/module/home/screen/home_screen.dart';
import 'package:cat_store/module/login/screen/login_screen.dart';
import 'package:cat_store/module/onboarding/screen/onboarding_screen.dart';
import 'package:cat_store/module/product/detail/screen/product_detail_screen.dart';
import 'package:cat_store/module/product/list/screen/product_list_screen.dart';
import 'package:cat_store/module/profile/screen/profile_screen.dart';
import 'package:cat_store/module/splash/screen/splash_screen.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:cat_store/utility/route/route_definition.dart';

class Routes {
  const Routes._();

  static const splash = RouteDefinition(name: '/');
  static const onBoarding = RouteDefinition(name: '/onBoarding');
  static const home = RouteDefinition(name: '/home');
  static const login = RouteDefinition(name: '/login');
  static const productDetail = RouteDefinition(name: '/productDetail');

  /// Bottom Navigation
  static const productList = RouteDefinition(name: '/productList');
  static const profile = RouteDefinition(name: '/profile');
}

class AppRoute {
  const AppRoute._();

  static void initialize(AppRouter appRouter) {
    appRouter
      ..registerRoute(
        Routes.splash,
        (_, __) => const SplashScreen(),
      )
      ..registerRoute(
        Routes.onBoarding,
        (_, __) => const OnBoardingScreen(),
      )
      ..registerRoute(
        Routes.home,
        (_, __) => const HomeScreen(),
      )
      ..registerRoute(
        Routes.login,
        (_, __) => const LoginScreen(),
      )
      ..registerRoute(
        Routes.productList,
        (_, __) => const ProductListScreen(),
      )
      ..registerRoute(
        Routes.profile,
        (_, __) => const ProfileScreen(),
      )
      ..registerRoute(
        Routes.productDetail,
        (_, information) => ProductDetailScreen(
          item: information.argument as ProductResponse,
        ),
      );
  }
}
