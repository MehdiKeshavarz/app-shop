import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data/models/cart_item_model.dart';
import 'package:shop_app/data/models/category_model.dart';
import 'package:shop_app/data/models/image_product_model.dart';
import 'package:shop_app/data/models/product_model.dart';
import 'package:shop_app/data/models/product_variant_model.dart';
import 'package:shop_app/data/models/property_product_model.dart';
import 'package:shop_app/data/repositories/basket_repository.dart';
import 'package:shop_app/di/locator.dart';

import '../../data/repositories/detail_product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  DetailProductRepository detailProductRepository =
      locator<DetailProductRepository>();

  BasketRepository basketRepository = locator<BasketRepository>();

  ProductBloc() : super(ProductInitialState()) {
    on<ProductInitializeEvent>((event, emit) async {
      emit(ProductLoadingState());

      var productImages =
          await detailProductRepository.getImagesProduct(event.productId);
      var productVariants =
          await detailProductRepository.getProductVariant(event.productId);
      var productCategory =
          await detailProductRepository.getProductCategory(event.categoryId);

      var productProperty =
          await detailProductRepository.getProductProperty(event.productId);

      emit(ProductLoadedState(
        imageProductList: productImages,
        productVariant: productVariants,
        productCategory: productCategory,
        productProperty: productProperty,
      ));
    });

    on<ProductAddToBasket>((event, emit) {
      var basketItem = CartItemMode(
        id: event.product.id,
        thumbnail: event.product.thumbnail,
        price: event.product.price,
        discountPrice: event.product.discountPrice,
        collectionId: event.product.collectionId,
        name: event.product.name,
        categoryId: event.product.categoryId,
      );
      basketRepository.addProductToBasket(basketItem);
    });
  }
}
