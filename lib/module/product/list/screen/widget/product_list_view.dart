import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:cat_store/utility/extension/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductListView extends StatelessWidget {
  final ProductResponse item;
  final Function(ProductResponse) onPressed;

  const ProductListView({
    Key? key,
    required this.item,
    required this.onPressed,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 10,
              child: CachedNetworkImage(
                imageUrl: item.thumbnail,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppDimen.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title.asTitleCase,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.light(),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${item.price}',
                          style: AppTextStyle.regular(
                              size: AppDimen.fontMediumLarge),
                        ),
                        const SizedBox(height: AppDimen.paddingMedium),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                              size: AppDimen.iconSizeMedium,
                            ),
                            const SizedBox(width: AppDimen.paddingExtraSmall),
                            Text(
                              item.rating.toStringAsFixed(1),
                              style: AppTextStyle.regular(),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
