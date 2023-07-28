class VariantModel {
  String? name;
  String? id;
  String? typeId;
  String? value;
  int? priceChange;

  VariantModel({
    this.name,
    this.id,
    this.typeId,
    this.value,
    this.priceChange,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      name: json['name'],
      id: json['id'],
      typeId: json['type_id'],
      value: json['value'],
      priceChange: json['price_change'],
    );
  }
}
