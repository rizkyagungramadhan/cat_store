import 'package:cat_store/common/app_assets.dart';

// ignore_for_file: lines_longer_than_80_chars
enum OnBoardingContent {
  one(
    1,
    AppAssets.onBoardOne,
    'Discount everywhere everytime',
    'Welcome to our platform! With us, you can enjoy discounts everywhere and every time you shop. Whether you\'re looking for fashion, beauty, or home essentials, we\'ve got you covered. Simply browse our selection of products and see the savings for yourself. It\'s that easy!',
  ),
  two(
    2,
    AppAssets.onBoardTwo,
    'We are open 24/7',
    'With us, you can shop at any time of the day or night. Whether you\'re an early bird or a night owl, we\'re always open and ready to serve you. So go ahead, take a look around, and shop whenever it\'s convenient for you.',
  ),
  three(
    3,
    AppAssets.onBoardThree,
    'Simple Action, Just Click & Collect',
    'Our platform makes shopping a breeze with our Click & Collect feature. Simply select the items you want to purchase, and we\'ll have them ready for you to pick up at your convenience. No more waiting in long lines or dealing with shipping delays. With Click & Collect, it\'s simple and hassle-free.',
  );

  final int order;
  final String image;
  final String title;
  final String description;

  const OnBoardingContent(
    this.order,
    this.image,
    this.title,
    this.description,
  );
}
