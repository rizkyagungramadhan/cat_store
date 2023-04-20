import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:cat_store/utility/extension/build_context_ext.dart';
import 'package:cat_store/utility/extension/string_ext.dart';
import 'package:flutter/material.dart';

class ProductListItemView extends StatelessWidget {
  final ProductResponse item;

  const ProductListItemView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageSize = 80.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimen.paddingMedium),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: imageSize,
              maxWidth: imageSize,
              minHeight: imageSize,
              minWidth: imageSize,
            ),
            child: CachedNetworkImage(
              imageUrl: item.thumbnail,
              fit: BoxFit.contain,
              memCacheWidth: context.fitImageCache(imageSize),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimen.paddingMedium,
                horizontal: AppDimen.paddingLarge,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title.asTitleCase,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.light(),
                  ),
                  const SizedBox(height: AppDimen.paddingMedium),
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
          ),
        ],
      ),
    );
  }
}
