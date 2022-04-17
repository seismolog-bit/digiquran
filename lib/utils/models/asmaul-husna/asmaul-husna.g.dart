// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asmaul-husna.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelAsmaulHusnaAdapter extends TypeAdapter<ModelAsmaulHusna> {
  @override
  final int typeId = 7;

  @override
  ModelAsmaulHusna read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelAsmaulHusna(
      data: (fields[0] as List?)?.cast<ModelAsmaulHusnaList>(),
    );
  }

  @override
  void write(BinaryWriter writer, ModelAsmaulHusna obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelAsmaulHusnaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
