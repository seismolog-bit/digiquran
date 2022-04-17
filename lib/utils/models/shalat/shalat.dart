import 'package:digiquran/utils/models/shalat/shalat-result.dart';
import 'package:hive/hive.dart';

part 'shalat.g.dart';

@HiveType(typeId: 9)
class ModelShalat {
  @HiveField(0)
  int? code;
  @HiveField(1)
  String? status;
  @HiveField(2)
  ShalatResult? results;

  ModelShalat({this.code, this.status, this.results});

  ModelShalat.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    results =
        json['results'] != null ? new ShalatResult.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.results != null) {
      data['results'] = this.results!.toJson();
    }
    return data;
  }
}









// class Location {
//   double? latitude;
//   double? longitude;
//   int? elevation;
//   String? country;
//   String? countryCode;
//   String? timezone;
//   int? localOffset;

//   Location(
//       {this.latitude,
//       this.longitude,
//       this.elevation,
//       this.country,
//       this.countryCode,
//       this.timezone,
//       this.localOffset});

//   Location.fromJson(Map<String, dynamic> json) {
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     elevation = json['elevation'];
//     country = json['country'];
//     countryCode = json['country_code'];
//     timezone = json['timezone'];
//     localOffset = json['local_offset'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['elevation'] = this.elevation;
//     data['country'] = this.country;
//     data['country_code'] = this.countryCode;
//     data['timezone'] = this.timezone;
//     data['local_offset'] = this.localOffset;
//     return data;
//   }
// }

// class Settings {
//   String? timeformat;
//   String? school;
//   String? juristic;
//   String? highlat;
//   int? fajrAngle;
//   int? ishaAngle;

//   Settings(
//       {this.timeformat,
//       this.school,
//       this.juristic,
//       this.highlat,
//       this.fajrAngle,
//       this.ishaAngle});

//   Settings.fromJson(Map<String, dynamic> json) {
//     timeformat = json['timeformat'];
//     school = json['school'];
//     juristic = json['juristic'];
//     highlat = json['highlat'];
//     fajrAngle = json['fajr_angle'];
//     ishaAngle = json['isha_angle'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['timeformat'] = this.timeformat;
//     data['school'] = this.school;
//     data['juristic'] = this.juristic;
//     data['highlat'] = this.highlat;
//     data['fajr_angle'] = this.fajrAngle;
//     data['isha_angle'] = this.ishaAngle;
//     return data;
//   }
// }
