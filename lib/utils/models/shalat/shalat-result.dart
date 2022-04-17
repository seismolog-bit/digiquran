import 'package:digiquran/utils/models/shalat/shalat-datetime.dart';
import 'package:hive/hive.dart';

part 'shalat-result.g.dart';

@HiveType(typeId: 10)
class ShalatResult {
  @HiveField(0)
  List<ShalatDatetime>? datetime;
  // Location? location;
  // Settings? settings;

  ShalatResult({this.datetime});

  ShalatResult.fromJson(Map<String, dynamic> json) {
    if (json['datetime'] != null) {
      datetime = <ShalatDatetime>[];
      json['datetime'].forEach((v) {
        datetime!.add(new ShalatDatetime.fromJson(v));
      });
    }
    // location = json['location'] != null
    //     ? new Location.fromJson(json['location'])
    //     : null;
    // settings = json['settings'] != null
    //     ? new Settings.fromJson(json['settings'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datetime != null) {
      data['datetime'] = this.datetime!.map((v) => v.toJson()).toList();
    }
    // if (this.location != null) {
    //   data['location'] = this.location!.toJson();
    // }
    // if (this.settings != null) {
    //   data['settings'] = this.settings!.toJson();
    // }
    return data;
  }
}