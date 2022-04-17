// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayah.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelAyahAdapter extends TypeAdapter<ModelAyah> {
  @override
  final int typeId = 2;

  @override
  ModelAyah read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelAyah(
      surahId: fields[0] as int?,
      verseId: fields[1] as int?,
      ayahText: fields[2] as String?,
      indoText: fields[3] as String?,
      enText: fields[4] as String?,
      readText: fields[5] as String?,
      juz: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelAyah obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.surahId)
      ..writeByte(1)
      ..write(obj.verseId)
      ..writeByte(2)
      ..write(obj.ayahText)
      ..writeByte(3)
      ..write(obj.indoText)
      ..writeByte(4)
      ..write(obj.enText)
      ..writeByte(5)
      ..write(obj.readText)
      ..writeByte(6)
      ..write(obj.juz);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelAyahAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
