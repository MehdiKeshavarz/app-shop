import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/category_data_source.dart';
import 'package:shop_app/data/models/category_model.dart';
import 'package:shop_app/data/models/product_model.dart';
import 'package:shop_app/di/locator.dart';
import 'package:shop_app/utils/api_exception.dart';

abstract class CategoryRepository {
  Future<Either<String, List<CategoryModel>>> getCategoryData();
  Future<Either<String, List<ProductModel>>> getProductCategoryData(
      String categoryId);
}

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource dataSource = locator<CategoryDataSource>();

  @override
  Future<Either<String, List<CategoryModel>>> getCategoryData() async {
    try {
      var categoryData = await dataSource.fetchCategoryData();
      return right(categoryData);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getProductCategoryData(
      String categoryId) async {
    try {
      var productCategoryData =
          await dataSource.fetchProductCategory(categoryId);
      return right(productCategoryData);
    } on ApiException catch (e) {
      return left(e.message ?? 'مشکلی به وجود امده است');
    }
  }
}
