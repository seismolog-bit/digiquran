import 'dart:convert';

import 'package:intl/intl.dart';

class ConvertTime{

  static String time_1 = 'dd MMM yyyy';
  static String time_2 = 'dd MMMM yyyy';
  static String time_3 = 'HH:mm';
  static String time_4 = 'yyyy-MM-dd'; 

  static const List<String> haris = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];

  static String hari(String day){
    if(day == 'Mon'){
      return 'Senin';
    } else if(day == 'Tue'){
      return 'Selasa';
    } else if(day == 'Wed'){
      return 'Rabu';
    } else if(day == 'Thu'){
      return 'Kamis';
    } else if(day == 'Fri'){
      return 'Jumat';
    } else if(day == 'Sat'){
      return 'Sabtu';
    }else{
      return 'Minggu';
    }
  }

  static String getTimeCon(var format, String time) {
    var date = time;
    var f = DateFormat(format).parse(time);
    return f.toString();
  }

  static String convertUtf8(String data) {
    var varData = data.codeUnits;
    return utf8.decode(varData);
  }

  static String getTime(var format) {
    var date = DateTime.now();
    var f = DateFormat(format);
    return f.format(date);
  }

  static int timeToInt(String time) {
    List<String> listData = time.split(':');
    // print(time.split(':'));
    // print((int.parse(listData[0]) * 60) + int.parse(listData[1])*60);
    return ((int.parse(listData[0]) * 60) + int.parse(listData[1]));
  }

  

  static int timeHouse(String time) {
    List<String> listData = time.split(':');
    // print(time.split(':'));
    // print((int.parse(listData[0]) * 60) + int.parse(listData[1])*60);
    return ((int.parse(listData[0]) * 60));
  }
}

class ShalatTime {
  static String shubuh = 'Shubuh';
  static String dhuhur = 'Dhuhur';
  static String ashar = 'Ashar';
  static String maghrib = 'Maghrib';
  static String isya = 'Isya';
}