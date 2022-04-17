
import 'package:hive/hive.dart';

part 'verse.g.dart';

@HiveType(typeId: 10)
class ModelVerse {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? number;
  @HiveField(2)
  String? text;
  @HiveField(3)
  String? translationId;
  @HiveField(4)
  int? juzId;
  @HiveField(5)
  int? surahId;
  @HiveField(6)
  String? transliteration;

  ModelVerse(
      {this.id,
      this.number,
      this.text,
      this.translationId,
      this.juzId,
      this.surahId,
      this.transliteration});

  ModelVerse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    text = json['text'];
    translationId = json['translation_id'];
    juzId = json['juz_id'];
    surahId = json['surah_id'];
    transliteration = json['transliteration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['text'] = this.text;
    data['translation_id'] = this.translationId;
    data['juz_id'] = this.juzId;
    data['surah_id'] = this.surahId;
    data['transliteration'] = this.transliteration;
    return data;
  }
}