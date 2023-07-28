class ProductModel {
  String? collectionId;
  String? id;
  String? description;
  String? thumbnail;
  int? discountPrice;
  int? price;
  String? popularity;
  String? name;
  int? quantity;
  String? categoryId;

  ProductModel({
    this.collectionId,
    this.id,
    this.description,
    this.thumbnail,
    this.discountPrice,
    this.price,
    this.popularity,
    this.name,
    this.quantity,
    this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      collectionId: json['collectionId'],
      id: json['id'],
      description: json['description'],
      thumbnail:
          'http://startflutter.ir/api/files/${json['collectionId']}/${json['id']}/${json['thumbnail']}',
      discountPrice: json['discount_price'],
      price: json['price'],
      popularity: json['popularity'],
      name: json['name'],
      quantity: json['quantity'],
      categoryId: json['category'],
    );
  }
}
