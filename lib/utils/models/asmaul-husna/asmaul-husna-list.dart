import 'package:hive/hive.dart';

part 'asmaul-husna-list.g.dart';

@HiveType(typeId: 8)
class ModelAsmaulHusnaList {
  @HiveField(0)
  int? urutan;
  @HiveField(1)
  String? latin;
  @HiveField(2)
  String? arab;
  @HiveField(3)
  String? arti;

  ModelAsmaulHusnaList({this.urutan, this.latin, this.arab, this.arti});

  ModelAsmaulHusnaList.fromJson(Map<String, dynamic> json) {
    urutan = json['urutan'];
    latin = json['latin'];
    arab = json['arab'];
    arti = json['arti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['urutan'] = this.urutan;
    data['latin'] = this.latin;
    data['arab'] = this.arab;
    data['arti'] = this.arti;
    return data;
  }
}