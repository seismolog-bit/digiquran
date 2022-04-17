import 'asmaul-husna-list.dart';
import 'package:hive/hive.dart';

part 'asmaul-husna.g.dart';

@HiveType(typeId: 7)
class ModelAsmaulHusna {
  @HiveField(0)
  List<ModelAsmaulHusnaList>? data;

  ModelAsmaulHusna({this.data});

  ModelAsmaulHusna.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ModelAsmaulHusnaList>[];
      json['data'].forEach((v) {
        data!.add(new ModelAsmaulHusnaList.fromJson(v));
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


