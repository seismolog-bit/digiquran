import 'package:digiquran/utils/text-style.dart';
import 'package:flutter/material.dart';

class ImageNumber extends StatelessWidget {
  final String? number;
  final TextStyle ? style;
  const ImageNumber({Key? key, required this.number, required this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23,
      width: 23,
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/clip-ayat.png'), fit: BoxFit.contain)),
      alignment: Alignment.center,
      child: Text(number!, style: style),
    );
  }
}
