// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shalat-datetime.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShalatDatetimeAdapter extends TypeAdapter<ShalatDatetime> {
  @override
  final int typeId = 11;

  @override
  ShalatDatetime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShalatDatetime(
      times: fields[0] as ShalatTimes?,
      date: fields[1] as ShalatDate?,
    );
  }

  @override
  void write(BinaryWriter writer, ShalatDatetime obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.times)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShalatDatetimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
