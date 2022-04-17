import 'package:hive/hive.dart';

part 'shalat-time.g.dart';

@HiveType(typeId: 12)
class ShalatTimes {
  @HiveField(0)
  String? imsak;
  @HiveField(1)
  String? sunrise;
  @HiveField(2)
  String? fajr;
  @HiveField(3)
  String? dhuhr;
  @HiveField(4)
  String? asr;
  @HiveField(5)
  String? sunset;
  @HiveField(6)
  String? maghrib;
  @HiveField(7)
  String? isha;
  @HiveField(8)
  String? midnight;

  ShalatTimes(
      {this.imsak,
      this.sunrise,
      this.fajr,
      this.dhuhr,
      this.asr,
      this.sunset,
      this.maghrib,
      this.isha,
      this.midnight});

  ShalatTimes.fromJson(Map<String, dynamic> json) {
    imsak = json['Imsak'];
    sunrise = json['Sunrise'];
    fajr = json['Fajr'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    sunset = json['Sunset'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
    midnight = json['Midnight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Imsak'] = this.imsak;
    data['Sunrise'] = this.sunrise;
    data['Fajr'] = this.fajr;
    data['Dhuhr'] = this.dhuhr;
    data['Asr'] = this.asr;
    data['Sunset'] = this.sunset;
    data['Maghrib'] = this.maghrib;
    data['Isha'] = this.isha;
    data['Midnight'] = this.midnight;
    return data;
  }
}

class IntShalatTime {
  int? imsak;
  int? sunrise;
  int? fajr;
  int? dhuhr;
  int? asr;
  int? sunset;
  int? maghrib;
  int? isha;
  int? midnight;

  IntShalatTime({
    required this.imsak,
    required this.sunrise,
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.midnight,
  });
}
