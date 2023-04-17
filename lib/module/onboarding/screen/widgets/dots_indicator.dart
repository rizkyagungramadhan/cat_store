import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  final Color color;

  /// The base size of the dots
  static const double _kDotSize = 11.0;

  /// The increase in the size of the selected dot
  static const double _kMaxZoom = 1.0;

  /// The distance between the center of each dot
  static const double _kDotSpacing = 20.0;

  const DotsIndicator({
    Key? key,
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    this.color = Colors.black,
  }) : super(key: key, listenable: controller);

  Widget _buildDot(int index) {
    var selectness = Curves.easeOut.transform(
      max(
        0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    var zoom = 1.0 + (_kMaxZoom - 1.0) * selectness;
    return SizedBox(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: Color.fromRGBO(
            color.red,
            color.green,
            color.blue,
            max(selectness, 0.1),
          ),
          type: MaterialType.circle,
          child: SizedBox(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
