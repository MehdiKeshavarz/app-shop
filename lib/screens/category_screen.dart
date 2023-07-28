import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Widgets/cached_image.dart';
import 'package:shop_app/Widgets/custom_appbar.dart';
import 'package:shop_app/Widgets/loading_items.dart';
import 'package:shop_app/bloc/category_bloc/category_bloc.dart';

import '../constants/color_palette.dart';
import '../data/models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(FetchCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // AppBar custom
            const SliverToBoxAdapter(
              child: CustomAppBar(
                textTitle: 'دسته بندی',
                isSearch: false,
              ),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const SliverToBoxAdapter(
                    child: LoadingItems(title: 'درحال جستجو'),
                  );
                }
                if (state is CategoryLoaded) {
                  return ListCategories(categoryList: state.categoryList);
                }
                if (state is CategoryError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        state.messageError,
                        style: const TextStyle(fontFamily: 'sb', fontSize: 24),
                      ),
                    ),
                  );
                }
                return SliverToBoxAdapter(child: Container());
              },
            )
          ],
        ),
      ),
    );
  }
}

class ListCategories extends StatelessWidget {
  final List<CategoryModel> categoryList;
  const ListCategories({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 15),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return CachedImage(imageUrl: categoryList[index].thumbnail);
        }, childCount: categoryList.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
