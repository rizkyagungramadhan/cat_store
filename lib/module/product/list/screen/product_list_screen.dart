import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/product/list/product_list_view_model.dart';
import 'package:cat_store/module/product/list/screen/widget/product_list_view.dart';
import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
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
    });

    return ChangeNotifierProvider(
      create: (_) => viewModel..init(),
      builder: (context, _) {
        return SafeArea(
          child: Scaffold(
            body: RefreshIndicator(
              backgroundColor: Colors.white,
              color: AppColor.primary,
              onRefresh: () async {
                viewModel.pagingController.refresh();
                // return viewModel.getProducts(0);
              },
              child: Padding(
                padding: const EdgeInsets.all(AppDimen.paddingLarge),
                child: PagedGridView(
                  pagingController: viewModel.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<ProductResponse>(
                    itemBuilder: (context, item, index) => ProductListView(
                      item: item,
                      onPressed: (_) {},
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppDimen.paddingExtraLarge,
                    crossAxisSpacing: AppDimen.paddingExtraLarge,
                    childAspectRatio: 1.0,
                  ),

                  // builderDelegate: PagedChildBuilderDelegate<ProductResponse>(
                  //   itemBuilder: (context, item, index) => ProductListView(
                  //     item: item,
                  //     onPressed: (_) {},
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
