import 'package:hive/hive.dart';

part 'doa-list.g.dart';

@HiveType(typeId: 4)
class ModelDoaList {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? doa;
  @HiveField(2)
  String? ayat;
  @HiveField(3)
  String? latin;
  @HiveField(4)
  String? artinya;

  ModelDoaList({this.id, this.doa, this.ayat, this.latin, this.artinya});

  ModelDoaList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doa = json['doa'];
    ayat = json['ayat'];
    latin = json['latin'];
    artinya = json['artinya'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doa'] = this.doa;
    data['ayat'] = this.ayat;
    data['latin'] = this.latin;
    data['artinya'] = this.artinya;
    return data;
  }
}