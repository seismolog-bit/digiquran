// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niat-shalat-list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelNiatShalatListAdapter extends TypeAdapter<ModelNiatShalatList> {
  @override
  final int typeId = 6;

  @override
  ModelNiatShalatList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelNiatShalatList(
      name: fields[0] as String?,
      arab: fields[1] as String?,
      latin: fields[2] as String?,
      means: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelNiatShalatList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.arab)
      ..writeByte(2)
      ..write(obj.latin)
      ..writeByte(3)
      ..write(obj.means);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelNiatShalatListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
