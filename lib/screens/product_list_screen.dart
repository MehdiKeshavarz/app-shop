import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Widgets/custom_appbar.dart';
import 'package:shop_app/Widgets/loading_items.dart';
import 'package:shop_app/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/constants/color_palette.dart';
import 'package:shop_app/data/models/category_model.dart';

import '../Widgets/product_item_card.dart';

class ProductListScreen extends StatefulWidget {
  final CategoryModel category;

  const ProductListScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    context
        .read<CategoryBloc>()
        .add(FetchCategoryProductEvent(categoryId: widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorPalette.backgroundColor,
        body: SafeArea(
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: CustomAppBar(
                      textTitle: widget.category.title!,
                      isSearch: false,
                    ),
                  ),
                  if (state is CategoryLoading) ...{
                    const SliverToBoxAdapter(
                      child: Center(
                        child: LoadingItems(title: 'درحال جستجوی محصول'),
                      ),
                    )
                  },
                  if (state is CategoryProductLoaded) ...{
                    state.categoryProductList.fold((errorMessage) {
                      print(errorMessage);
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Text('محصولی پیدا نشد. تلاش دوباره'),
                        ),
                      );
                    }, (categoryProduct) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        sliver: SliverGrid(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return ProductItemCard(
                                productItem: categoryProduct[index]);
                          }, childCount: categoryProduct.length),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 2 / 2.6,
                                  mainAxisSpacing: 20),
                        ),
                      );
                    }),
                  },
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
