import 'package:cat_store/module/home/const/home_navigation_items.dart';
import 'package:equatable/equatable.dart';

class HomePresentation extends Equatable {
  final HomeNavigationItem activeTab;

  const HomePresentation({
    this.activeTab = HomeNavigationItem.productList,
  });

  HomePresentation copyWith({HomeNavigationItem? activeTab}) {
    return HomePresentation(
      activeTab: activeTab ?? this.activeTab,
    );
  }

  @override
  List<Object> get props => [activeTab];
}
