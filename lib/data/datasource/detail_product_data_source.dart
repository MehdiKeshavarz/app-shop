import 'package:dio/dio.dart';
import 'package:shop_app/data/models/image_product_model.dart';
import 'package:shop_app/data/models/product_variant_model.dart';
import 'package:shop_app/data/models/property_product_model.dart';
import 'package:shop_app/data/models/variant_model.dart';

import '../../di/locator.dart';
import '../../utils/api_exception.dart';
import '../models/category_model.dart';
import '../models/variant_type_model.dart';

abstract class DetailProductDataSource {
  Future<List<ImageProductModel>> fetchImagesProduct(String productId);
  Future<List<VariantTypeModel>> fetchVariantType();
  Future<List<VariantModel>> fetchVariant(String productId);
  Future<List<ProductVariantModel>> fetchProductVariant(String productId);
  Future<CategoryModel> fetchProductCategory(String categoryId);
  Future<List<PropertyProductModel>> fetchProductProperty(String productId);
}

class DetailProductDataSourceImpl implements DetailProductDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<ImageProductModel>> fetchImagesProduct(String productId) async {
    Map<String, String> qParams = {'filter': 'product_id="$productId"'};
    try {
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qParams);

      return response.data['items']
          .map<ImageProductModel>((json) => ImageProductModel.fromJson(json))
          .toList();
    } on DioError catch (e) {
      throw ApiException(
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 0);
    }
  }

  @override
  Future<List<VariantTypeModel>> fetchVariantType() async {
    try {
      var response = await _dio.get('collections/variants_type/records');
      return response.data['items']
          .map<VariantTypeModel>((json) => VariantTypeModel.fromJson(json))
          .toList();
    } on DioError catch (e) {
      throw ApiException(
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 0);
    }
  }

  @override
  Future<List<VariantModel>> fetchVariant(String productId) async {
    Map<String, String> qParams = {'filter': 'product_id="$productId"'};
    try {
      var response = await _dio.get('collections/variants/records',
          queryParameters: qParams);
      return response.data['items']
          .map<VariantModel>((json) => VariantModel.fromJson(json))
          .toList();
    } on DioError catch (e) {
      throw ApiException(
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 0);
    }
  }

  @override
  Future<List<ProductVariantModel>> fetchProductVariant(
      String productId) async {
    var variantTypeList = await fetchVariantType();
    var variantList = await fetchVariant(productId);

    try {
      List<ProductVariantModel> productVariantList = [];

      for (var variantType in variantTypeList) {
        var listVariant = variantList
            .where((element) => element.typeId == variantType.id)
            .toList();

        productVariantList.add(ProductVariantModel(variantType, listVariant));
      }

      return productVariantList;
      ;
    } on DioError catch (e) {
      throw ApiException(
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 0);
    }
  }

  @override
  Future<CategoryModel> fetchProductCategory(String categoryId) async {
    Map<String, String> qParams = {'filter': 'id="$categoryId"'};

    try {
      var response = await _dio.get('collections/category/records',
          queryParameters: qParams);

      return CategoryModel.fromJson(response.data['items'][0]);
    } on DioError catch (e) {
      throw ApiException(
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 0);
    }
  }

  @override
  Future<List<PropertyProductModel>> fetchProductProperty(
      String productId) async {
    Map<String, String> qParams = {'filter': 'product_id="$productId"'};

    try {
      var response = await _dio.get('collections/properties/records',
          queryParameters: qParams);
      return response.data['items']
          .map<PropertyProductModel>(
              (json) => PropertyProductModel.fromJson(json))
          .toList();
    } on DioError catch (e) {
      throw ApiException(
        message: e.response?.data['message'],
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 0);
    }
  }
}
