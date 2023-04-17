import 'package:flutter/material.dart';

enum HomeNavigationItem {
  productList('Products', Icons.shopping_cart_rounded),
  profile('Profile', Icons.person_rounded);

  final String title;
  final IconData icon;

  const HomeNavigationItem(this.title, this.icon);
}
