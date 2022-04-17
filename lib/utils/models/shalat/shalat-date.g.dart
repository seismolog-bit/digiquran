// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shalat-date.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShalatDateAdapter extends TypeAdapter<ShalatDate> {
  @override
  final int typeId = 13;

  @override
  ShalatDate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShalatDate(
      timestamp: fields[0] as int?,
      gregorian: fields[1] as String?,
      hijri: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ShalatDate obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.gregorian)
      ..writeByte(2)
      ..write(obj.hijri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShalatDateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
