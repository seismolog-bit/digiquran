// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asmaul-husna-list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelAsmaulHusnaListAdapter extends TypeAdapter<ModelAsmaulHusnaList> {
  @override
  final int typeId = 8;

  @override
  ModelAsmaulHusnaList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelAsmaulHusnaList(
      urutan: fields[0] as int?,
      latin: fields[1] as String?,
      arab: fields[2] as String?,
      arti: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelAsmaulHusnaList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.urutan)
      ..writeByte(1)
      ..write(obj.latin)
      ..writeByte(2)
      ..write(obj.arab)
      ..writeByte(3)
      ..write(obj.arti);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelAsmaulHusnaListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
