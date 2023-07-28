import 'package:shop_app/data/models/variant_model.dart';
import 'package:shop_app/data/models/variant_type_model.dart';

class ProductVariantModel {
  VariantTypeModel variantType;
  List<VariantModel> variantList;

  ProductVariantModel(this.variantType, this.variantList);
}
