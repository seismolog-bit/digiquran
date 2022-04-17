
import 'package:digiquran/utils/models/list-surah.dart';
import 'package:hive/hive.dart';

part 'surah.g.dart';

@HiveType(typeId: 0)
class ModelSurah extends HiveObject{
  @HiveField(0)
  late List<ModelListSurah>? features;

  ModelSurah({this.features});

  ModelSurah.fromJson(Map<String, dynamic> json) {
    if (json['features'] != null) {
      features = <ModelListSurah>[];
      json['features'].forEach((v) {
        features!.add(new ModelListSurah.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



