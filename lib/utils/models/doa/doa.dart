import 'doa-list.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'doa.g.dart';

@HiveType(typeId: 3)
class ModelDoa {
  @HiveField(0)
  List<ModelDoaList>? data;

  ModelDoa({this.data});

  ModelDoa.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ModelDoaList>[];
      json['data'].forEach((v) {
        data!.add(new ModelDoaList.fromJson(v));
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