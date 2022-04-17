import 'package:carousel_slider/carousel_slider.dart';
import 'package:digiquran/utils/models/shalat/shalat-time.dart';
import 'package:digiquran/utils/text-style.dart';
import 'package:digiquran/utils/utils.dart';
import 'package:flutter/material.dart';

class CarouselShalat extends StatelessWidget {
  final ShalatTimes? shalatTimes;
  final IntShalatTime? intShalatTime;
  const CarouselShalat(
      {Key? key, required this.shalatTimes, required this.intShalatTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _intDate =
        ConvertTime.timeToInt(ConvertTime.getTime(ConvertTime.time_3));
    late int initPage;

    if (_intDate >= intShalatTime!.imsak! && _intDate < intShalatTime!.fajr!) {
      initPage = 1;
    } else if (_intDate >= intShalatTime!.fajr! && _intDate < intShalatTime!.dhuhr!) {
      initPage = 2;
    } else if (_intDate >= intShalatTime!.dhuhr! && _intDate < intShalatTime!.asr!) {
      initPage = 3;
    } else if (_intDate >= intShalatTime!.asr! && _intDate < intShalatTime!.maghrib!) {
      initPage = 4;
    } else if (_intDate >= intShalatTime!.maghrib! && _intDate < intShalatTime!.isha!) {
      initPage = 5;
    }else if (_intDate >= intShalatTime!.isha! && _intDate < intShalatTime!.midnight!) {
      initPage = 6;
    }else{
      initPage = 0;
    }

    return SizedBox(
      height: 72,
      child: CarouselSlider(
        items: [
          tileShalat('Imsak ${shalatTimes!.imsak}', Icons.ac_unit),
          tileShalat('Subuh ${shalatTimes!.fajr}', Icons.ac_unit),
          // tileShalat('Terbit ${shalatTimes!.sunrise}', Icons.ac_unit),
          tileShalat('Dzuhur ${shalatTimes!.dhuhr}', Icons.ac_unit),
          tileShalat('Ashar ${shalatTimes!.asr}', Icons.ac_unit),
          // tileShalat('Terbenam ${shalatTimes!.sunset}', Icons.ac_unit),
          tileShalat('Magrib ${shalatTimes!.maghrib}', Icons.ac_unit),
          tileShalat('Isya ${shalatTimes!.isha}', Icons.ac_unit),
          tileShalat('Tengah malam ${shalatTimes!.midnight}', Icons.ac_unit),
        ],
        options: CarouselOptions(
          aspectRatio: 2.0,
          viewportFraction: .8,
          reverse: false,
          enableInfiniteScroll: false,
          initialPage: initPage,
        ),
      ),
    );
  }

  Widget tileShalat(String title, IconData icon) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: defaultText.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              color: Colors.deepPurple[300],
            )
          ],
        ),
      ),
    );
  }
}
