import 'package:cat_store/module/home/const/home_navigation_items.dart';
import 'package:cat_store/module/home/home_presentation.dart';
import 'package:cat_store/utility/view_model_mixin.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier with ViewModelMixin {
  HomePresentation _presentation = const HomePresentation();

  HomePresentation get presentation => _presentation;

  void changeTab(HomeNavigationItem selectedTab) {
    try {
      _presentation = presentation.copyWith(activeTab: selectedTab);
      notifyListeners();
    } catch (error) {
      logError(error);
    }
  }
}
