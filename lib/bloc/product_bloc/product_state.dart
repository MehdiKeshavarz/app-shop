part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final Either<String, List<ImageProductModel>> imageProductList;
  final Either<String, List<ProductVariantModel>> productVariant;
  final Either<String, CategoryModel> productCategory;
  final Either<String, List<PropertyProductModel>> productProperty;
  ProductLoadedState({
    required this.imageProductList,
    required this.productVariant,
    required this.productCategory,
    required this.productProperty,
  });
}

class ProductErrorState extends ProductState {}
