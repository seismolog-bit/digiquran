import 'package:hive/hive.dart';

import 'verse.dart';

part 'quran.g.dart';

@HiveType(typeId: 9)
class ModelQuran {
  @HiveField(0)
  List<ModelVerse>? data;

  ModelQuran({this.data});

  ModelQuran.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ModelVerse>[];
      json['data'].forEach((v) {
        data!.add(new ModelVerse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

