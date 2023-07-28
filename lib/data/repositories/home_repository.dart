import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/home_data_source.dart';
import 'package:shop_app/data/models/banner_model.dart';
import 'package:shop_app/data/models/product_model.dart';
import 'package:shop_app/di/locator.dart';
import 'package:shop_app/utils/api_exception.dart';

abstract class HomeRepository {
  Future<Either<String, List<BannerModel>>> getBannerData();
  Future<Either<String, List<ProductModel>>> getProductData();
  Future<Either<String, List<ProductModel>>> getBestSellerProductData();
  Future<Either<String, List<ProductModel>>> getMostVisitedProductData();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource homeDataSource = locator<HomeDataSource>();

  @override
  Future<Either<String, List<BannerModel>>> getBannerData() async {
    try {
      var bannerData = await homeDataSource.fetchBannerData();
      return right(bannerData);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getProductData() async {
    try {
      var productData = await homeDataSource.fetchProductData();
      return right(productData);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getBestSellerProductData() async {
    try {
      var productBestSellerData =
          await homeDataSource.fetchBestSellerProductData();
      return right(productBestSellerData);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getMostVisitedProductData() async {
    try {
      var productMostVisitedData =
          await homeDataSource.fetchMostVisitedProductData();
      return right(productMostVisitedData);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
