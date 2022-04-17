// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelQuranAdapter extends TypeAdapter<ModelQuran> {
  @override
  final int typeId = 9;

  @override
  ModelQuran read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelQuran(
      data: (fields[0] as List?)?.cast<ModelVerse>(),
    );
  }

  @override
  void write(BinaryWriter writer, ModelQuran obj) {
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
      other is ModelQuranAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
