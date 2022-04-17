class ModelSettings {
  bool? latin;
  bool? translate;
  bool? line;

  ModelSettings({this.latin, this.translate, this.line});

  ModelSettings.fromJson(Map<String, dynamic> json) {
    latin = json['latin'];
    translate = json['translate'];
    line = json['line'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latin'] = this.latin;
    data['translate'] = this.translate;
    data['line'] = this.line;
    return data;
  }
}