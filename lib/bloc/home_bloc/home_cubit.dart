import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_app/data/models/product_model.dart';
import 'package:shop_app/data/repositories/category_repository.dart';
import 'package:shop_app/data/repositories/home_repository.dart';
import 'package:shop_app/di/locator.dart';

import '../../data/models/banner_model.dart';
import '../../data/models/category_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository homeRepository = locator<HomeRepository>();
  CategoryRepository categoryRepository = locator<CategoryRepository>();

  HomeCubit() : super(HomeInitial());

  void getBanner() async {
    emit(HomeLoading());
    var bannerData = await homeRepository.getBannerData();
    var categoryData = await categoryRepository.getCategoryData();
    var productData = await homeRepository.getProductData();
    var productBestSellerData = await homeRepository.getBestSellerProductData();
    var productMostVisitedData =
        await homeRepository.getMostVisitedProductData();
    emit(HomeLoaded(
      bannerList: bannerData,
      categoryList: categoryData,
      productList: productData,
      productBestSellerList: productBestSellerData,
      productMostVisitedList: productMostVisitedData,
    ));
  }
}
