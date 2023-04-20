import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/common/app_assets.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/product/list/product_list_presentation.dart';
import 'package:cat_store/module/product/list/product_list_view_model.dart';
import 'package:cat_store/module/product/list/screen/widget/product_list_view.dart';
import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:cat_store/style/app_text_style.dart';
import 'package:cat_store/utility/extension/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = serviceLocator<ProductListViewModel>();

    context.onBuildCompleted(() {
      viewModel.init();
      viewModel.getProducts(0);
      viewModel.getFeaturedProduct();
    });

    return ChangeNotifierProvider(
      create: (_) => viewModel,
      builder: (context, _) {
        final isAppBarPinned = context.select(
          (ProductListViewModel model) => model.presentation.isAppBarPinned,
        );
        final isItemNotEmpty = context.select(
          (ProductListViewModel model) => model.presentation.isItemNotEmpty,
        );
        final itemViewType = context.select(
          (ProductListViewModel model) => model.presentation.itemViewType,
        );
        return Container(
          color: isAppBarPinned ? AppColor.primary : Colors.black,
          child: SafeArea(
            child: Scaffold(
              body: RefreshIndicator(
                backgroundColor: Colors.white,
                color: AppColor.primary,
                onRefresh: () async {
                  viewModel.pagingController.refresh();
                },
                child: CustomScrollView(
                  controller: viewModel.scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        height: 40,
                        color: Colors.black,
                        padding: const EdgeInsets.all(AppDimen.paddingMedium),
                        child: Center(
                          child: Text(
                            'Free Shipping to All Over the World',
                            style: AppTextStyle.regular(
                              color: AppColor.whiteLike,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverAppBar(
                      expandedHeight: kToolbarHeight,
                      pinned: true,
                      backgroundColor: AppColor.primary,
                      flexibleSpace: Image.asset(AppAssets.appLogo),
                      actions: isAppBarPinned
                          ? [
                              Tooltip(
                                message: 'Back to top',
                                child: IconButton(
                                  onPressed: () {
                                    viewModel.scrollController.animateTo(
                                      0,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInCubic,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.swipe_up_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ]
                          : [],
                    ),
                    const SliverToBoxAdapter(
                      child: _FeaturedProductSection(),
                    ),
                    if (isItemNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimen.paddingLarge,
                            vertical: AppDimen.paddingMedium,
                          ),
                          child: Text(
                            'Explore Products that Fits You',
                            style: AppTextStyle.bold(size: AppDimen.fontLarge),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppDimen.paddingLarge,
                            left: AppDimen.paddingLarge,
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft:
                                        Radius.circular(AppDimen.paddingMedium),
                                    bottomLeft:
                                        Radius.circular(AppDimen.paddingMedium),
                                  ),
                                  color: itemViewType == ItemViewType.grid
                                      ? AppColor.grayDark
                                      : AppColor.grayLight,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    viewModel.switchItemView(ItemViewType.grid);
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.all(AppDimen.paddingMedium),
                                    child: Icon(
                                      Icons.grid_view_rounded,
                                      size: AppDimen.iconSizeMedium,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight:
                                        Radius.circular(AppDimen.paddingMedium),
                                    bottomRight:
                                        Radius.circular(AppDimen.paddingMedium),
                                  ),
                                  color: itemViewType == ItemViewType.list
                                      ? AppColor.grayDark
                                      : AppColor.grayLight,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    viewModel.switchItemView(ItemViewType.list);
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.all(AppDimen.paddingMedium),
                                    child: Icon(
                                      Icons.list_rounded,
                                      size: AppDimen.iconSizeMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        left: AppDimen.paddingLarge,
                        right: AppDimen.paddingLarge,
                        bottom: AppDimen.paddingLarge,
                      ),
                      sliver: _ItemListView(
                        itemViewType: itemViewType,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ItemListView extends StatelessWidget {
  final ItemViewType itemViewType;

  const _ItemListView({
    Key? key,
    required this.itemViewType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProductListViewModel>();

    switch (itemViewType) {
      case ItemViewType.grid:
        return PagedSliverGrid(
          pagingController: viewModel.pagingController,
          builderDelegate: PagedChildBuilderDelegate<ProductResponse>(
            itemBuilder: (context, item, index) => ProductListView(
              item: item,
              itemViewType: itemViewType,
              onPressed: (product) => viewModel.openDetailProduct(product),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppDimen.paddingExtraLarge,
            crossAxisSpacing: AppDimen.paddingExtraLarge,
            childAspectRatio: 1.0,
          ),
        );
      case ItemViewType.list:
        return PagedSliverList(
          pagingController: viewModel.pagingController,
          builderDelegate: PagedChildBuilderDelegate<ProductResponse>(
            itemBuilder: (context, item, index) => ProductListView(
              item: item,
              itemViewType: itemViewType,
              onPressed: (product) => viewModel.openDetailProduct(product),
            ),
          ),
        );
    }
  }
}

class _FeaturedProductSection extends StatelessWidget {
  const _FeaturedProductSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = context.select(
      (ProductListViewModel value) => value.presentation.featuredProduct,
    );
    final carouselPosition = context.select(
      (ProductListViewModel value) => value.presentation.carouselPosition,
    );

    if (item is! ProductResponse) return const SizedBox.shrink();
    if (item.images.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(AppDimen.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Featured Product',
            style: AppTextStyle.bold(size: AppDimen.fontLarge),
          ),
          const SizedBox(height: AppDimen.paddingMedium),
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 4,
              autoPlay: true,
              onPageChanged: (index, _) {
                context
                    .read<ProductListViewModel>()
                    .changeCarouselPosition(index);
              },
            ),
            items: item.images.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  final imageWidth = MediaQuery.of(context).size.width;

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppDimen.paddingSmall,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(AppDimen.radiusMedium),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.grayDark.withOpacity(0.6),
                          offset: const Offset(0, 0.5),
                          blurRadius: AppDimen.paddingMedium,
                          spreadRadius: 0.25,
                        ),
                      ],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.contain,
                      memCacheWidth: context.fitImageCache(imageWidth),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: item.images.map((imageUrl) {
              var index = item.images.indexOf(imageUrl);
              return Container(
                width: AppDimen.iconSizeSmall,
                height: AppDimen.iconSizeSmall,
                margin: const EdgeInsets.symmetric(
                  vertical: AppDimen.paddingLarge,
                  horizontal: AppDimen.paddingSuperSmall,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: carouselPosition == index
                      ? AppColor.primary
                      : AppColor.accent,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
