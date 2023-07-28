part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Either<String, List<BannerModel>> bannerList;
  final Either<String, List<CategoryModel>> categoryList;
  final Either<String, List<ProductModel>> productList;
  final Either<String, List<ProductModel>> productBestSellerList;
  final Either<String, List<ProductModel>> productMostVisitedList;
  HomeLoaded({
    required this.bannerList,
    required this.categoryList,
    required this.productList,
    required this.productBestSellerList,
    required this.productMostVisitedList,
  });
}
