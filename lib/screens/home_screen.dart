import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Widgets/banner_slider.dart';
import 'package:shop_app/Widgets/shimmer_effect/home_shimmer.dart';
import 'package:shop_app/bloc/home_bloc/home_cubit.dart';

import '../Widgets/category_item_chip.dart';
import '../Widgets/category_name.dart';
import '../Widgets/product_item_card.dart';
import '../constants/color_palette.dart';
import '../data/models/category_model.dart';
import '../data/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().getBanner();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isShowTitle = false;
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              shrinkWrap: true,
              slivers: [
                const _GetSearchBox(),
                if (state is HomeLoading) ...[
                  const SliverToBoxAdapter(child: HomeShimmer())
                ],
                if (state is HomeLoaded) ...[
                  state.bannerList.fold(
                    (errorMessage) {
                      return SliverToBoxAdapter(
                          child: Center(child: Text(errorMessage)));
                    },
                    (bannerList) {
                      return SliverToBoxAdapter(
                          child: BannerSlider(bannerList: bannerList));
                    },
                  ),
                ],
                if (state is HomeLoaded) const _GetCategoryTitle(),
                if (state is HomeLoaded) ...[
                  state.categoryList.fold(
                    (errorMessage) {
                      return SliverToBoxAdapter(
                          child: Center(child: Text(errorMessage)));
                    },
                    (categoryList) {
                      return _GetCategoryList(categoryList: categoryList);
                    },
                  )
                ],
                const SliverToBoxAdapter(
                    child: CategoryName(categoryName: 'پرفروش ترین ها')),
                if (state is HomeLoaded) ...[
                  state.productBestSellerList.fold(
                    (errorMessage) {
                      return SliverToBoxAdapter(
                          child: Center(child: Text(errorMessage)));
                    },
                    (productList) {
                      return _GetBestSellerProducts(productList: productList);
                    },
                  ),
                ],
                const SliverToBoxAdapter(
                  child: CategoryName(categoryName: 'پر بازدیدترین ها'),
                ),
                if (state is HomeLoaded) ...[
                  state.productMostVisitedList.fold(
                    (errorMessage) {
                      return SliverToBoxAdapter(
                          child: Center(child: Text(errorMessage)));
                    },
                    (productList) {
                      return _GetMostViewedProducts(productList: productList);
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _GetMostViewedProducts extends StatelessWidget {
  final List<ProductModel> productList;
  const _GetMostViewedProducts({
    super.key,
    required this.productList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 15.0),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: ProductItemCard(productItem: productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetBestSellerProducts extends StatelessWidget {
  final List<ProductModel> productList;
  const _GetBestSellerProducts({
    super.key,
    required this.productList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 12.0),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: ProductItemCard(productItem: productList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetCategoryList extends StatelessWidget {
  final List<CategoryModel> categoryList;
  const _GetCategoryList({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: CategoryItemChip(
                    categoryItem: categoryList[index],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _GetCategoryTitle extends StatelessWidget {
  const _GetCategoryTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.0, right: 15.0, bottom: 12.0),
            child: Text(
              'دسته بندی',
              style: TextStyle(
                  fontSize: 12, fontFamily: 'sm', color: ColorPalette.gery),
            ),
          ),
        ],
      ),
    );
  }
}

class _GetSearchBox extends StatelessWidget {
  const _GetSearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(right: 15, left: 15, bottom: 20, top: 20),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 16),
              Image.asset('assets/images/icon_search.png'),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'جستجوی محصولات',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16, fontFamily: 'sb', color: ColorPalette.gery),
                ),
              ),
              Image.asset('assets/images/icon_apple_blue.png'),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
