import 'niat-shalat-list.dart';
import 'package:hive/hive.dart';

part 'niat-shalat.g.dart';

@HiveType(typeId: 5)
class ModelNiatShalat {
  @HiveField(0)
  List<ModelNiatShalatList>? data;

  ModelNiatShalat({this.data});

  ModelNiatShalat.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ModelNiatShalatList>[];
      json['data'].forEach((v) {
        data!.add(new ModelNiatShalatList.fromJson(v));
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


