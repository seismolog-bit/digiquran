// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shalat-result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShalatResultAdapter extends TypeAdapter<ShalatResult> {
  @override
  final int typeId = 10;

  @override
  ShalatResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShalatResult(
      datetime: (fields[0] as List?)?.cast<ShalatDatetime>(),
    );
  }

  @override
  void write(BinaryWriter writer, ShalatResult obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.datetime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShalatResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
