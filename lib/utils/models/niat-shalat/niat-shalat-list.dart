import 'package:hive/hive.dart';

part 'niat-shalat-list.g.dart';

@HiveType(typeId: 6)
class ModelNiatShalatList {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? arab;
  @HiveField(2)
  String? latin;
  @HiveField(3)
  String? means;

  ModelNiatShalatList({this.name, this.arab, this.latin, this.means});

  ModelNiatShalatList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    arab = json['arab'];
    latin = json['latin'];
    means = json['means'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['arab'] = this.arab;
    data['latin'] = this.latin;
    data['means'] = this.means;
    return data;
  }
}