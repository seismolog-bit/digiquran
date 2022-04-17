// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doa.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelDoaAdapter extends TypeAdapter<ModelDoa> {
  @override
  final int typeId = 3;

  @override
  ModelDoa read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelDoa(
      data: (fields[0] as List?)?.cast<ModelDoaList>(),
    );
  }

  @override
  void write(BinaryWriter writer, ModelDoa obj) {
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
      other is ModelDoaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
