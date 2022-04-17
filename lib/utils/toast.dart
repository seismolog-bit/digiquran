import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast{
  static show(String msg){
    Fluttertoast.showToast(
      msg: msg,
      // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[300],
      textColor: Colors.black,
      fontSize: 13.0,
    );
  }
}