import 'package:flutter/material.dart';

String convertArabicNumber(int number) {
  String res = '';

  String num = number.toString();

  final arabics = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩',];
  num.characters.forEach((element) {
     res += arabics[int.parse(element)];
  }); 
  
  return res;
}