// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemModeAdapter extends TypeAdapter<CartItemMode> {
  @override
  final int typeId = 0;

  @override
  CartItemMode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemMode(
      collectionId: fields[0] as String?,
      id: fields[1] as String?,
      thumbnail: fields[2] as String?,
      discountPrice: fields[3] as int?,
      price: fields[4] as int?,
      name: fields[5] as String?,
      categoryId: fields[6] as String?,
    )
      ..present = fields[7] as num?
      ..realPrice = fields[8] as int?;
  }

  @override
  void write(BinaryWriter writer, CartItemMode obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.collectionId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.thumbnail)
      ..writeByte(3)
      ..write(obj.discountPrice)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.categoryId)
      ..writeByte(7)
      ..write(obj.present)
      ..writeByte(8)
      ..write(obj.realPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
