import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/common/widgets/app_button.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/product/detail/product_detail_view_model.dart';
import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:cat_store/utility/extension/string_ext.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductResponse item;

  const ProductDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = serviceLocator<ProductDetailViewModel>();
    return ChangeNotifierProvider(
      create: (_) {
        // viewModel.init(item);
        return viewModel..init(item);
      },
      builder: (context, _) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  color: AppColor.accent,
                  iconSize: AppDimen.iconSizeExtraLarge,
                  onPressed: () => serviceLocator<AppRouter>().rootGoBack(),
                ),
                Expanded(
                  child: _MainProductContent(item: item),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MainProductContent extends StatelessWidget {
  final ProductResponse item;

  const _MainProductContent({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<ProductDetailViewModel>(
        builder: (context, model, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onPanUpdate: (data) {
                  context.read<ProductDetailViewModel>().swipeImage(data);
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: PageView(
                    controller: model.controller,
                    children: model.presentation.images
                        .map(
                          (e) => CachedNetworkImage(
                            imageUrl: e,
                            height: MediaQuery.of(context).size.height / 3,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: AppDimen.paddingMedium),
              _ProductImageCarousel(images: model.presentation.images),
              _ProductAttributeView(item: item),
            ],
          );
        },
      ),
    );
  }
}

class _ProductImageCarousel extends StatelessWidget {
  final List<String> images;

  const _ProductImageCarousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 64,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppDimen.paddingMedium),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: images
            .map(
              (imageUrl) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimen.paddingMedium),
                child: InkWell(
                  onTap: () {
                    final viewModel = context.read<ProductDetailViewModel>();
                    viewModel.onPageChanged(
                      viewModel.presentation.images.indexOf(imageUrl),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ProductAttributeView extends StatelessWidget {
  final ProductResponse item;

  const _ProductAttributeView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimen.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.brand.asTitleCase, style: AppTextStyle.light()),
          const SizedBox(height: AppDimen.paddingLarge),
          Text(
            item.title.asTitleCase,
            style: AppTextStyle.regular(
              size: AppDimen.fontLarge,
            ),
          ),
          const SizedBox(height: AppDimen.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${item.price}',
                style: AppTextStyle.regular(
                  size: AppDimen.fontLarge,
                  color: AppColor.primary,
                ),
              ),
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
              ),
            ],
          ),
          const SizedBox(height: AppDimen.paddingMedium),
          Row(
            children: [
              Text(
                'Stock: ',
                style: AppTextStyle.light(),
              ),
              Text(
                '${item.stock} left',
                style: AppTextStyle.light(
                  color:
                      item.stock < 50 ? Colors.orangeAccent : AppColor.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimen.paddingMedium),
          AppButton(
            onPressed: () {},
            textButton: 'Add to Cart',
            width: double.infinity,
          ),
          const SizedBox(height: AppDimen.paddingExtraLarge2),
          Text(
            'Description',
            style: AppTextStyle.regular(),
          ),
          const SizedBox(height: AppDimen.paddingLarge),
          Text(
            item.description,
            style: AppTextStyle.light(),
          ),
        ],
      ),
    );
  }
}
