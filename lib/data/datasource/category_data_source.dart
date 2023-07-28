import 'package:dio/dio.dart';
import 'package:shop_app/data/models/category_model.dart';
import 'package:shop_app/data/models/product_model.dart';
import 'package:shop_app/utils/api_exception.dart';

import '../../di/locator.dart';

abstract class CategoryDataSource {
  Future<List<CategoryModel>> fetchCategoryData();
  Future<List<ProductModel>> fetchProductCategory(String categoryId);
}

class CategoryDataSourceImpl implements CategoryDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<CategoryModel>> fetchCategoryData() async {
    try {
      var response = await _dio.get('collections/category/records');

      return response.data['items']
          .map<CategoryModel>((json) => CategoryModel.fromJson(json))
          .toList();
    } on DioError catch (e) {
      throw ApiException(
          message: e.response?.data['message'],
          statusCode: e.response?.statusCode);
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 0);
    }
  }

  @override
  Future<List<ProductModel>> fetchProductCategory(String categoryId) async {
    Map<String, String> qParams = {'filter': 'category="$categoryId"'};
    var response;
    try {
      if (categoryId == "78q8w901e6iipuk") {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: qParams);
      }

      return response.data['items']
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } on DioError catch (e) {
      throw ApiException(
          message: e.response?.data['message'],
          statusCode: e.response?.statusCode);
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 0);
    }
  }
}
