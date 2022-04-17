// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list-surah.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelListSurahAdapter extends TypeAdapter<ModelListSurah> {
  @override
  final int typeId = 1;

  @override
  ModelListSurah read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelListSurah(
      asma: fields[0] as String?,
      name: fields[1] as String?,
      quranNumber: fields[2] as int?,
      orderNumber: fields[3] as int?,
      numberOfAyahs: fields[4] as int?,
      typeId: fields[5] as String?,
      typeEn: fields[6] as String?,
      translationId: fields[7] as String?,
      translationEn: fields[8] as String?,
      text: (fields[9] as List?)?.cast<ModelAyah>(),
    );
  }

  @override
  void write(BinaryWriter writer, ModelListSurah obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.asma)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.quranNumber)
      ..writeByte(3)
      ..write(obj.orderNumber)
      ..writeByte(4)
      ..write(obj.numberOfAyahs)
      ..writeByte(5)
      ..write(obj.typeId)
      ..writeByte(6)
      ..write(obj.typeEn)
      ..writeByte(7)
      ..write(obj.translationId)
      ..writeByte(8)
      ..write(obj.translationEn)
      ..writeByte(9)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelListSurahAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
