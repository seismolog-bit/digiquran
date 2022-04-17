
import 'package:hive/hive.dart';

part 'ayah.g.dart';

@HiveType(typeId: 2)
class ModelAyah extends HiveObject{
  @HiveField(0)
  int? surahId;
  @HiveField(1)
  int? verseId;
  @HiveField(2)
  String? ayahText;
  @HiveField(3)
  String? indoText;
  @HiveField(4)
  String? enText;
  @HiveField(5)
  String? readText;
  @HiveField(6)
  int? juz;

  ModelAyah(
      {this.surahId,
      this.verseId,
      this.ayahText,
      this.indoText,
      this.enText,
      this.readText,
      this.juz});

  ModelAyah.fromJson(Map<String, dynamic> json) {
    surahId = json['surahId'];
    verseId = json['verseId'];
    ayahText = json['ayahText'];
    indoText = json['indoText'];
    enText = json['enText'];
    readText = json['readText'];
    juz = json['juz'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surahId'] = this.surahId;
    data['verseId'] = this.verseId;
    data['ayahText'] = this.ayahText;
    data['indoText'] = this.indoText;
    data['enText'] = this.enText;
    data['readText'] = this.readText;
    data['juz'] = this.juz;
    return data;
  }
}