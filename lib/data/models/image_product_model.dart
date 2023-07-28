class ImageProductModel {
  String? imageUrl;
  String? productId;

  ImageProductModel({this.imageUrl, this.productId});

  factory ImageProductModel.fromJson(Map<String, dynamic> json) {
    return ImageProductModel(
      imageUrl:
          'http://startflutter.ir/api/files/${json['collectionId']}/${json['id']}/${json['image']}',
      productId: json['product_id'],
    );
  }
}
