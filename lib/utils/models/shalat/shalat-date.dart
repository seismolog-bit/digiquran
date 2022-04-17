import 'package:hive/hive.dart';

part 'shalat-date.g.dart';

@HiveType(typeId: 13)
class ShalatDate {
  @HiveField(0)
  int? timestamp;
  @HiveField(1)
  String? gregorian;
  @HiveField(2)
  String? hijri;

  ShalatDate({this.timestamp, this.gregorian, this.hijri});

  ShalatDate.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    gregorian = json['gregorian'];
    hijri = json['hijri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['gregorian'] = this.gregorian;
    data['hijri'] = this.hijri;
    return data;
  }
}