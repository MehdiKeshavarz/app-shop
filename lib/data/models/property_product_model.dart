class PropertyProductModel {
  String? id;
  String? productId;
  String? title;
  String? value;

  PropertyProductModel({
    this.id,
    this.productId,
    this.title,
    this.value,
  });

  factory PropertyProductModel.fromJson(Map<String, dynamic> json) {
    return PropertyProductModel(
      id: json['id'],
      productId: json['product_id'],
      title: json['title'],
      value: json['value'],
    );
  }
}
