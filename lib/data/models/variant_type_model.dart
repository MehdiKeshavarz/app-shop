class VariantTypeModel {
  String? id;
  String? name;
  String? title;
  VariantType? type;

  VariantTypeModel({this.id, this.name, this.title, this.type});

  factory VariantTypeModel.fromJson(Map<String, dynamic> json) {
    return VariantTypeModel(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      type: _getTypeEnum(json['type']),
    );
  }
}

VariantType? _getTypeEnum(String? type) {
  switch (type) {
    case "Color":
      return VariantType.COLOR;
    case "Storage":
      return VariantType.STORAGE;
    case "Voltage":
      return VariantType.VOLTAGE;
  }
  return null;
}

enum VariantType {
  COLOR,
  STORAGE,
  VOLTAGE,
}
