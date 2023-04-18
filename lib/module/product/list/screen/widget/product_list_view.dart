import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/module/product/list/product_list_presentation.dart';
import 'package:cat_store/module/product/widgets/product_grid_item_view.dart';
import 'package:cat_store/module/product/widgets/product_list_item_view.dart';
import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  final ProductResponse item;
  final Function(ProductResponse) onPressed;
  final ItemViewType itemViewType;

  const ProductListView({
    Key? key,
    required this.item,
    required this.onPressed,
    required this.itemViewType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(item),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimen.radiusMedium),
          boxShadow: [
            BoxShadow(
              color: AppColor.grayDark.withOpacity(0.3),
              offset: const Offset(0, 0.2),
              blurRadius: AppDimen.paddingMedium,
              spreadRadius: 0.25,
            ),
          ],
        ),
        child: () {
          switch (itemViewType) {
            case ItemViewType.grid:
              return ProductGridItemView(item: item);
            case ItemViewType.list:
              return ProductListItemView(item: item);
          }
        }(),
      ),
    );
  }
}
