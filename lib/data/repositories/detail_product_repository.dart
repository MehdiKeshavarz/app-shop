import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/detail_product_data_source.dart';
import 'package:shop_app/data/models/category_model.dart';
import 'package:shop_app/data/models/image_product_model.dart';
import 'package:shop_app/data/models/product_variant_model.dart';
import 'package:shop_app/data/models/property_product_model.dart';
import 'package:shop_app/data/models/variant_type_model.dart';
import 'package:shop_app/di/locator.dart';

import '../../utils/api_exception.dart';

abstract class DetailProductRepository {
  Future<Either<String, List<ImageProductModel>>> getImagesProduct(
      String productId);
  Future<Either<String, List<VariantTypeModel>>> getVariantType();

  Future<Either<String, List<ProductVariantModel>>> getProductVariant(
      String productId);
  Future<Either<String, CategoryModel>> getProductCategory(String categoryId);
  Future<Either<String, List<PropertyProductModel>>> getProductProperty(
      String productId);
}

class DetailProductRepositoryImpl implements DetailProductRepository {
  DetailProductDataSource detailProductDataSource =
      locator<DetailProductDataSource>();
  @override
  Future<Either<String, List<ImageProductModel>>> getImagesProduct(
      String productId) async {
    try {
      var imagesProductData =
          await detailProductDataSource.fetchImagesProduct(productId);
      return right(imagesProductData);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<VariantTypeModel>>> getVariantType() async {
    try {
      var variantTypeData = await detailProductDataSource.fetchVariantType();
      return right(variantTypeData);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductVariantModel>>> getProductVariant(
      String productId) async {
    try {
      var productVariant =
          await detailProductDataSource.fetchProductVariant(productId);
      return right(productVariant);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, CategoryModel>> getProductCategory(
      String categoryId) async {
    try {
      var productCategory =
          await detailProductDataSource.fetchProductCategory(categoryId);
      return right(productCategory);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<PropertyProductModel>>> getProductProperty(
      String productId) async {
    try {
      var productCategory =
          await detailProductDataSource.fetchProductProperty(productId);
      return right(productCategory);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
