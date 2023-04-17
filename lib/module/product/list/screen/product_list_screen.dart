import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/common/app_assets.dart';
import 'package:cat_store/di/service_locator.dart';
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
                      actions: isAppBarPinned ? [
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
                      ] : [],
                    ),
                    const SliverToBoxAdapter(
                      child: _FeaturedProductSection(),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimen.paddingLarge),
                        child: Text(
                          'Explore Products that Fits You',
                          style: AppTextStyle.bold(size: AppDimen.fontLarge),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        left: AppDimen.paddingLarge,
                        right: AppDimen.paddingLarge,
                        bottom: AppDimen.paddingLarge,
                      ),
                      sliver: PagedSliverGrid(
                        // shrinkWrap: false,
                        // physics: const ClampingScrollPhysics(),
                        pagingController: viewModel.pagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<ProductResponse>(
                          itemBuilder: (context, item, index) =>
                              ProductListView(
                            item: item,
                            onPressed: (product) =>
                                viewModel.openDetailProduct(product),
                          ),
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: AppDimen.paddingExtraLarge,
                          crossAxisSpacing: AppDimen.paddingExtraLarge,
                          childAspectRatio: 1.0,
                        ),
                      ),
                    ),
                    // SliverFillRemaining(
                    //   fillOverscroll: true,
                    //   child: Expanded(
                    //     child: PagedGridView(
                    //       shrinkWrap: false,
                    //       physics: const ClampingScrollPhysics(),
                    //       pagingController: viewModel.pagingController,
                    //       builderDelegate:
                    //       PagedChildBuilderDelegate<ProductResponse>(
                    //         itemBuilder: (context, item, index) =>
                    //             ProductListView(
                    //               item: item,
                    //               onPressed: (product) =>
                    //                   viewModel.openDetailProduct(product),
                    //             ),
                    //       ),
                    //       gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2,
                    //         mainAxisSpacing: AppDimen.paddingExtraLarge,
                    //         crossAxisSpacing: AppDimen.paddingExtraLarge,
                    //         childAspectRatio: 1.0,
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                // child: Padding(
                //   padding: const EdgeInsets.all(AppDimen.paddingLarge),
                //   child: SingleChildScrollView(
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       // crossAxisAlignment: CrossAxisAlignment.stretch,
                //       // mainAxisSize: MainAxisSize.max,
                //       children: [
                //         // Container(height: 100, width: 200, color: Colors.red,),
                //         // const _FeaturedProductSection(),
                //         const SizedBox(height: AppDimen.paddingExtraLarge2),
                //         Expanded(
                //           child: PagedGridView(
                //             shrinkWrap: false,
                //             physics: const ClampingScrollPhysics(),
                //             pagingController: viewModel.pagingController,
                //             builderDelegate:
                //                 PagedChildBuilderDelegate<ProductResponse>(
                //               itemBuilder: (context, item, index) =>
                //                   ProductListView(
                //                 item: item,
                //                 onPressed: (product) =>
                //                     viewModel.openDetailProduct(product),
                //               ),
                //             ),
                //             gridDelegate:
                //                 const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 2,
                //               mainAxisSpacing: AppDimen.paddingExtraLarge,
                //               crossAxisSpacing: AppDimen.paddingExtraLarge,
                //               childAspectRatio: 1.0,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
        );
      },
    );
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
