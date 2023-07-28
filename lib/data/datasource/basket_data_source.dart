import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_app/data/models/cart_item_model.dart';

abstract class BasketDataSource {
  Future<void> addProduct(CartItemMode cartItem);
  Future<List<CartItemMode>> getAllBasketItem();
  Future<int> getBasketFinalPrice();
}

class BasketLocalDataSourceImpl extends BasketDataSource {
  var box = Hive.box<CartItemMode>('cartBox');
  @override
  Future<void> addProduct(CartItemMode cartItem) async {
    box.add(cartItem);
  }

  @override
  Future<List<CartItemMode>> getAllBasketItem() async {
    return box.values.toList();
  }

  @override
  Future<int> getBasketFinalPrice() async {
    var productCartList = box.values.toList();
    var finalPrice = productCartList.fold(
        0, (accumulator, productCart) => accumulator + productCart.realPrice!);
    return finalPrice;
  }
}
