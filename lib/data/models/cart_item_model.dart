import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemMode {
  @HiveField(0)
  String? collectionId;
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? thumbnail;
  @HiveField(3)
  int? discountPrice;
  @HiveField(4)
  int? price;
  @HiveField(5)
  String? name;
  @HiveField(6)
  String? categoryId;
  @HiveField(7)
  num? present;
  @HiveField(8)
  int? realPrice;

  CartItemMode({
    this.collectionId,
    this.id,
    this.thumbnail,
    this.discountPrice,
    this.price,
    this.name,
    this.categoryId,
  }) {
    realPrice = price! + discountPrice!;
    present = ((price! - realPrice!) / price!) * 100;
  }
}
