part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categoryList;
  CategoryLoaded({
    required this.categoryList,
  });
}

class CategoryProductLoaded extends CategoryState {
  final Either<String, List<ProductModel>> categoryProductList;
  CategoryProductLoaded({
    required this.categoryProductList,
  });
}

class CategoryError extends CategoryState {
  final String messageError;
  CategoryError({required this.messageError});
}
