part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class ProductInitializeEvent extends ProductEvent {
  final String productId;
  final String categoryId;
  ProductInitializeEvent({required this.productId, required this.categoryId});
}

class ProductAddToBasket extends ProductEvent {
  final ProductModel product;
  ProductAddToBasket({required this.product});
}
