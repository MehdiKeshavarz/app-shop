import 'package:dartz/dartz.dart';
import 'package:shop_app/data/datasource/basket_data_source.dart';
import 'package:shop_app/data/models/cart_item_model.dart';
import 'package:shop_app/di/locator.dart';

abstract class BasketRepository {
  Future<Either<String, String>> addProductToBasket(CartItemMode cartItem);
  Future<Either<String, List<CartItemMode>>> getAllBasketItems();
  Future<int> getBasketFinalPrice();
}

class BasketRepositoryImpl extends BasketRepository {
  BasketDataSource basketDataSource = locator.get();

  @override
  Future<Either<String, String>> addProductToBasket(
      CartItemMode cartItem) async {
    try {
      basketDataSource.addProduct(cartItem);
      print('success');
      return right('محصول به سبد خرید اضافه شد');
    } catch (e) {
      print(e);
      return left('خطا در افزودن محصول به سبد خرید');
    }
  }

  @override
  Future<Either<String, List<CartItemMode>>> getAllBasketItems() async {
    try {
      var listItemBasket = await basketDataSource.getAllBasketItem();
      return right(listItemBasket);
    } catch (e) {
      return left('محصولی یافت نشد');
    }
  }

  @override
  Future<int> getBasketFinalPrice() async {
    var finalPrice = await basketDataSource.getBasketFinalPrice();
    return finalPrice;
  }
}
