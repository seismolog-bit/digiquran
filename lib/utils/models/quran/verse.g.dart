// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelVerseAdapter extends TypeAdapter<ModelVerse> {
  @override
  final int typeId = 10;

  @override
  ModelVerse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelVerse(
      id: fields[0] as int?,
      number: fields[1] as int?,
      text: fields[2] as String?,
      translationId: fields[3] as String?,
      juzId: fields[4] as int?,
      surahId: fields[5] as int?,
      transliteration: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelVerse obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.translationId)
      ..writeByte(4)
      ..write(obj.juzId)
      ..writeByte(5)
      ..write(obj.surahId)
      ..writeByte(6)
      ..write(obj.transliteration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelVerseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
