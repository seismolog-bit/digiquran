
import 'package:digiquran/utils/models/ayah.dart';
import 'package:hive/hive.dart';

part 'list-surah.g.dart';

@HiveType(typeId: 1)
class ModelListSurah extends HiveObject{
  @HiveField(0)
  String? asma;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? quranNumber;
  @HiveField(3)
  int? orderNumber;
  @HiveField(4)
  int? numberOfAyahs;
  @HiveField(5)
  String? typeId;
  @HiveField(6)
  String? typeEn;
  @HiveField(7)
  String? translationId;
  @HiveField(8)
  String? translationEn;
  @HiveField(9)
  List<ModelAyah>? text;

  ModelListSurah(
      {this.asma,
      this.name,
      this.quranNumber,
      this.orderNumber,
      this.numberOfAyahs,
      this.typeId,
      this.typeEn,
      this.translationId,
      this.translationEn,
      this.text});

  ModelListSurah.fromJson(Map<String, dynamic> json) {
    asma = json['asma'];
    name = json['name'];
    quranNumber = json['quranNumber'];
    orderNumber = json['orderNumber'];
    numberOfAyahs = json['numberOfAyahs'];
    typeId = json['typeId'];
    typeEn = json['typeEn'];
    translationId = json['translationId'];
    translationEn = json['translationEn'];
    if (json['text'] != null) {
      text = <ModelAyah>[];
      json['text'].forEach((v) {
        text!.add(new ModelAyah.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['asma'] = this.asma;
    data['name'] = this.name;
    data['quranNumber'] = this.quranNumber;
    data['orderNumber'] = this.orderNumber;
    data['numberOfAyahs'] = this.numberOfAyahs;
    data['typeId'] = this.typeId;
    data['typeEn'] = this.typeEn;
    data['translationId'] = this.translationId;
    data['translationEn'] = this.translationEn;
    if (this.text != null) {
      data['text'] = this.text!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}