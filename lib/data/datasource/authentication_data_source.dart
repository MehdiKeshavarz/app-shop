import 'package:dio/dio.dart';
import 'package:shop_app/di/locator.dart';
import 'package:shop_app/utils/api_exception.dart';

abstract class AuthenticationDataSource {
  Future<void> register(
      String username, String password, String passwordConfirm);
  Future<String> login(String username, String password);
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final Dio _dio = locator.get();

  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
        'username': username,
        'password': password,
        'passwordConfirm': passwordConfirm
      });
      print('${response.statusCode}');
    } on DioError catch (ex) {
      throw ApiException(
        message: ex.response?.data['message'],
        statusCode: ex.response?.statusCode,
      );
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      var response = await _dio.post('collections/users/auth-with-password',
          data: {'identity': username, 'password': password});
      if (response.statusCode == 200) {
        return response.data?['token'];
      }
    } on DioError catch (ex) {
      throw ApiException(
          message: ex.response?.data['message'],
          statusCode: ex.response?.statusCode);
    } catch (ex) {
      ApiException(message: 'خطایی نامشخص', statusCode: 0);
    }

    return '';
  }
}
