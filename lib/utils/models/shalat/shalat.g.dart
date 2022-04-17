// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shalat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelShalatAdapter extends TypeAdapter<ModelShalat> {
  @override
  final int typeId = 9;

  @override
  ModelShalat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelShalat(
      code: fields[0] as int?,
      status: fields[1] as String?,
      results: fields[2] as ShalatResult?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelShalat obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.results);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelShalatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
