import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/authentication_data_source.dart';
import 'package:shop_app/di/locator.dart';
import 'package:shop_app/utils/api_exception.dart';
import 'package:shop_app/utils/auth_manager.dart';

abstract class IAuthenticationRepo {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);
  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepository implements IAuthenticationRepo {
  final AuthenticationDataSource _dataSource = locator.get();

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _dataSource.register('fardinkeshavrzz1', "12345678", "12345678");
      return right('ثبت نام انجام شد!');
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _dataSource.login(username, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right('ورود انجام شد!');
      } else {
        return left('خطایی درلحظه ورود پیش امده است!');
      }
    } on ApiException catch (ex) {
      return left('${ex.message}');
    }
  }
}
