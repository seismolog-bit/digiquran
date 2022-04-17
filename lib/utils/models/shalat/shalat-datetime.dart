import 'package:digiquran/utils/models/shalat/shalat-date.dart';
import 'package:digiquran/utils/models/shalat/shalat-time.dart';
import 'package:hive/hive.dart';

part 'shalat-datetime.g.dart';

@HiveType(typeId: 11)
class ShalatDatetime {
  @HiveField(0)
  ShalatTimes? times;
  @HiveField(1)
  ShalatDate? date;

  ShalatDatetime({this.times, this.date});

  ShalatDatetime.fromJson(Map<String, dynamic> json) {
    times = json['times'] != null ? new ShalatTimes.fromJson(json['times']) : null;
    date = json['date'] != null ? new ShalatDate.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.times != null) {
      data['times'] = this.times!.toJson();
    }
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    return data;
  }
}