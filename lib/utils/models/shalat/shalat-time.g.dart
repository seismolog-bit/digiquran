// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shalat-time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShalatTimesAdapter extends TypeAdapter<ShalatTimes> {
  @override
  final int typeId = 12;

  @override
  ShalatTimes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShalatTimes(
      imsak: fields[0] as String?,
      sunrise: fields[1] as String?,
      fajr: fields[2] as String?,
      dhuhr: fields[3] as String?,
      asr: fields[4] as String?,
      sunset: fields[5] as String?,
      maghrib: fields[6] as String?,
      isha: fields[7] as String?,
      midnight: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ShalatTimes obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.imsak)
      ..writeByte(1)
      ..write(obj.sunrise)
      ..writeByte(2)
      ..write(obj.fajr)
      ..writeByte(3)
      ..write(obj.dhuhr)
      ..writeByte(4)
      ..write(obj.asr)
      ..writeByte(5)
      ..write(obj.sunset)
      ..writeByte(6)
      ..write(obj.maghrib)
      ..writeByte(7)
      ..write(obj.isha)
      ..writeByte(8)
      ..write(obj.midnight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShalatTimesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
