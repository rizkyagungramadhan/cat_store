import 'package:cat_store/common/app_assets.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/splash/splash_view_model.dart';
import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/utility/extension/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = serviceLocator<SplashViewModel>();

    context.onBuildCompleted(() => viewModel.init());

    return ChangeNotifierProvider<SplashViewModel>(
      create: (_) => viewModel,
      child: Scaffold(
        backgroundColor: AppColor.grayLight,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.appLogo,
                width: 200,
                height: 200,
              ),
              const SizedBox(height: AppDimen.paddingSmall),
              const SizedBox(
                width: AppDimen.sizeLoadingIndicator,
                height: AppDimen.sizeLoadingIndicator,
                child: CircularProgressIndicator(
                  color: AppColor.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
