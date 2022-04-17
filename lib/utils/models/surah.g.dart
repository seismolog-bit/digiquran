// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surah.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelSurahAdapter extends TypeAdapter<ModelSurah> {
  @override
  final int typeId = 0;

  @override
  ModelSurah read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelSurah(
      features: (fields[0] as List?)?.cast<ModelListSurah>(),
    );
  }

  @override
  void write(BinaryWriter writer, ModelSurah obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.features);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelSurahAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
