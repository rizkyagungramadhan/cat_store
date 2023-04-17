import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/style/app_theme.dart';
import 'package:cat_store/utility/route/app_route.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRouter = serviceLocator<AppRouter>();

    return MaterialApp(
      title: 'Cat Store',
      debugShowCheckedModeBanner: kDebugMode,
      builder: (context, child) => MediaQuery(
        /// Lock font to always use 1.0 or normal
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child ?? const SizedBox.shrink(),
      ),
      navigatorKey: appRouter.rootNavigationKey,
      theme: AppTheme.theme,
      initialRoute: Routes.splash.name,
      onGenerateRoute: (RouteSettings settings) {
        return appRouter.generateRoute(settings);
      },
    );
  }
}
