import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/bloc/basket_bloc/basket_bloc.dart';
import 'package:shop_app/bloc/category_bloc/category_bloc.dart';
import 'package:shop_app/bloc/home_bloc/home_cubit.dart';
import 'package:shop_app/data/datasource/authentication_data_source.dart';
import 'package:shop_app/data/datasource/basket_data_source.dart';
import 'package:shop_app/data/datasource/category_data_source.dart';
import 'package:shop_app/data/datasource/detail_product_data_source.dart';
import 'package:shop_app/data/datasource/home_data_source.dart';
import 'package:shop_app/data/repositories/authentication_repository.dart';
import 'package:shop_app/data/repositories/basket_repository.dart';
import 'package:shop_app/data/repositories/category_repository.dart';
import 'package:shop_app/data/repositories/detail_product_repository.dart';
import 'package:shop_app/data/repositories/home_repository.dart';

import '../bloc/authentication_bloc/auth_bloc.dart';

var locator = GetIt.instance;

Future<void> setup() async {
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  //! dataSources
  locator.registerFactory<AuthenticationDataSource>(
      () => AuthenticationDataSourceImpl());
  locator.registerFactory<CategoryDataSource>(() => CategoryDataSourceImpl());
  locator.registerFactory<HomeDataSource>(() => HomeDataSourceImpl());
  locator.registerSingleton<BasketDataSource>(BasketLocalDataSourceImpl());

  locator.registerFactory<DetailProductDataSource>(
      () => DetailProductDataSourceImpl());

  //!Repositories
  locator.registerSingleton<IAuthenticationRepo>(AuthenticationRepository());
  locator.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());
  locator.registerSingleton<HomeRepository>(HomeRepositoryImpl());
  locator.registerSingleton<BasketRepository>(BasketRepositoryImpl());
  locator.registerSingleton<DetailProductRepository>(
      DetailProductRepositoryImpl());

  locator.registerSingleton<AuthBloc>(AuthBloc());
  locator.registerSingleton<CategoryBloc>(CategoryBloc());
  locator.registerSingleton<HomeCubit>(HomeCubit());
  locator.registerSingleton<BasketBloc>(BasketBloc());
}
