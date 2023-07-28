import 'package:dio/dio.dart';
import 'package:shop_app/utils/api_exception.dart';

import '../../di/locator.dart';
import '../models/banner_model.dart';
import '../models/product_model.dart';

abstract class HomeDataSource {
  Future<List<BannerModel>> fetchBannerData();
  Future<List<ProductModel>> fetchProductData();
  Future<List<ProductModel>> fetchMostVisitedProductData();
  Future<List<ProductModel>> fetchBestSellerProductData();
}

class HomeDataSourceImpl implements HomeDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerModel>> fetchBannerData() async {
    try {
      var response = await _dio.get('collections/banner/records');

      return response.data['items']
          .map<BannerModel>((json) => BannerModel.fromJson(json))
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
  Future<List<ProductModel>> fetchProductData() async {
    try {
      var response = await _dio.get('collections/products/records');

      return response.data['items']
          .map<ProductModel>((json) => ProductModel.fromJson(json))
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
  Future<List<ProductModel>> fetchBestSellerProductData() async {
    Map<String, String> qParams = {'filter': 'popularity="Best Seller"'};
    try {
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);

      return response.data['items']
          .map<ProductModel>((json) => ProductModel.fromJson(json))
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
  Future<List<ProductModel>> fetchMostVisitedProductData() async {
    Map<String, String> qParams = {'filter': 'popularity="Hotest"'};
    try {
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);

      return response.data['items']
          .map<ProductModel>((json) => ProductModel.fromJson(json))
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
