import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/home/const/home_navigation_items.dart';
import 'package:cat_store/module/home/home_view_model.dart';
import 'package:cat_store/module/product/list/screen/product_list_screen.dart';
import 'package:cat_store/module/profile/screen/profile_screen.dart';
import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = serviceLocator<HomeViewModel>();

    return ChangeNotifierProvider(
      create: (_) => viewModel,
      builder: (context, __) {
        final activeTab =
            context.select((HomeViewModel vm) => vm.presentation.activeTab);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: () {
            switch (activeTab) {
              case HomeNavigationItem.productList:
                return const ProductListScreen();
              case HomeNavigationItem.profile:
                return const ProfileScreen();
            }
          }(),
          bottomNavigationBar: BottomNavigationBar(
            items: HomeNavigationItem.values
                .map(
                  (item) => BottomNavigationBarItem(
                    icon: Icon(item.icon),
                    label: item.title,
                  ),
                )
                .toList(),
            currentIndex: HomeNavigationItem.values.indexOf(activeTab),
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColor.primary,
            selectedLabelStyle: AppTextStyle.light(
              color: AppColor.primary,
              size: AppDimen.fontMediumSmall,
            ),
            onTap: (selectedIndex) =>
                viewModel.changeTab(HomeNavigationItem.values[selectedIndex]),
            unselectedItemColor: AppColor.accent,
            unselectedLabelStyle: AppTextStyle.light(
              color: AppColor.accent,
              size: AppDimen.fontMediumSmall,
            ),
          ),
        );
      },
    );
  }
}
