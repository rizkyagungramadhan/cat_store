import 'package:cat_store/app.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/service/prefs_service/prefs_service.dart';
import 'package:cat_store/utility/route/app_route.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {

    setupServiceLocator();
    AppRoute.initialize(serviceLocator<AppRouter>());
    await serviceLocator<PrefsService>().initialize();

    runApp(const App());
  });
}