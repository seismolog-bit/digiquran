import 'package:carousel_slider/carousel_slider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:digiquran/utils/models/shalat/shalat-date.dart';
import 'package:digiquran/utils/models/shalat/shalat-time.dart';
import 'package:digiquran/utils/models/shalat/shalat.dart';
import 'package:digiquran/utils/text-style.dart';
import 'package:digiquran/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class ShalatScreen extends StatefulWidget {
  final ModelShalat? modelShalat;
  final String? jadwalShalat;
  // final Duration? timeDuration;
  final String? location;
  final String? city;
  const ShalatScreen({
    Key? key,
    required this.modelShalat,
    required this.jadwalShalat,
    // required this.timeDuration,
    required this.location,
    required this.city,
  }) : super(key: key);

  @override
  State<ShalatScreen> createState() => _ShalatScreenState();
}

class _ShalatScreenState extends State<ShalatScreen> {
  final CarouselController carouselController = CarouselController();
  int indexPage = DateTime.now().day;
  DateTime timeNow = DateTime.now();
  // late Duration shalatDuration;

  late int shalatColor;

  //Countdown
  // late CountdownController countdownController;

  @override
  void initState() {
    _fetchShalat();

    // countdownController = CountdownController(duration: shalatDuration);
    // countdownController.start();

    super.initState();
  }

  @override
  void dispose() {
    // countdownController.dispose();
    super.dispose();
  }

  Future _fetchShalat() async {
    try {
      ShalatTimes times =
          widget.modelShalat!.results!.datetime![(timeNow.day) - 1].times!;

      IntShalatTime _shalatTime = IntShalatTime(
        imsak: ConvertTime.timeToInt(times.imsak!),
        sunrise: ConvertTime.timeToInt(times.sunrise!),
        fajr: ConvertTime.timeToInt(times.fajr!),
        dhuhr: ConvertTime.timeToInt(times.dhuhr!),
        asr: ConvertTime.timeToInt(times.asr!),
        sunset: ConvertTime.timeToInt(times.sunset!),
        maghrib: ConvertTime.timeToInt(times.maghrib!),
        isha: ConvertTime.timeToInt(times.isha!),
        midnight: ConvertTime.timeToInt(times.midnight!),
      );

      //Duration
      // Duration _duration;
      int intTimeNow =
          ConvertTime.timeToInt(ConvertTime.getTime(ConvertTime.time_3));

      setState(() {
        if (intTimeNow < _shalatTime.imsak! || intTimeNow > _shalatTime.midnight!) {
          shalatColor = 1;
          // shalatDuration = Duration(minutes: (_shalatTime.imsak!)-intTimeNow, seconds: timeNow.second );
        }else if(intTimeNow > _shalatTime.imsak! && intTimeNow < _shalatTime.fajr!){
          shalatColor = 2;
          // shalatDuration = Duration(minutes: (_shalatTime.fajr!)-intTimeNow, seconds: timeNow.second );
        }else if(intTimeNow > _shalatTime.fajr! && intTimeNow < _shalatTime.sunrise!){
          shalatColor = 3;
          // shalatDuration = Duration(minutes: (_shalatTime.sunrise!)-intTimeNow, seconds: timeNow.second );
        }else if(intTimeNow > _shalatTime.sunrise! && intTimeNow < _shalatTime.dhuhr!){
          shalatColor = 4;
          // shalatDuration = Duration(minutes: (_shalatTime.dhuhr!)-intTimeNow, seconds: timeNow.second );
        }else if(intTimeNow > _shalatTime.dhuhr! && intTimeNow < _shalatTime.asr!){
          shalatColor = 5;
          // shalatDuration = Duration(minutes: (_shalatTime.asr!)-intTimeNow, seconds: timeNow.second );
        }else if(intTimeNow > _shalatTime.asr! && intTimeNow < _shalatTime.sunrise!){
          shalatColor = 6;
          // shalatDuration = Duration(minutes: (_shalatTime.sunrise!)-intTimeNow, seconds: timeNow.second );
        }else if(intTimeNow > _shalatTime.sunrise! && intTimeNow < _shalatTime.maghrib!){
          shalatColor = 7;
          // shalatDuration = Duration(minutes: (_shalatTime.maghrib!)-intTimeNow, seconds: timeNow.second );
        }else if(intTimeNow > _shalatTime.maghrib! && intTimeNow < _shalatTime.isha!){
          shalatColor = 8;
          // shalatDuration = Duration(minutes: (_shalatTime.isha!)-intTimeNow, seconds: timeNow.second );
        }else{
          shalatColor = 9;
          // shalatDuration = Duration(minutes: (_shalatTime.midnight!)-intTimeNow, seconds: timeNow.second );
        }
      });
    } catch (e) {
      print('Get Shalat: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Shalat'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Stack(children: [
            const SizedBox(
              height: 200,
              width: double.infinity,
            ),
            Container(
              height: 158,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background-home.png'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(46),
                  bottomRight: Radius.circular(46),
                ),
              ),
              child: shalatSelect(),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 72,
                  child: CarouselSlider(
                      carouselController: carouselController,
                      items: itemsPage(),
                      options: CarouselOptions(
                          aspectRatio: 2.0,
                          viewportFraction: .8,
                          reverse: false,
                          enableInfiniteScroll: false,
                          initialPage: indexPage - 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              indexPage = index;
                            });
                          })),
                ))
          ]),
          const SizedBox(height: 12),
          shalatTile()
        ],
      ),
    );
  }

  Widget shalatSelect() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const SizedBox(
        //   height: 72,
        // ),
        // Text(shalat!.results!.datetime![0].date!.gregorian!)

        // Countdown(
        //   countdownController: countdownController,
        //   builder: (_, timer) {
        //     if (timer.isNegative) {
        //       return const Text('Berlangsung');
        //     } else {
        //       return Text(
        //           '- ${timer.inHours.bitLength} : ${timer.inMinutes % 60} : ${timer.inSeconds % 60}');
        //     }
        //   },
        // ),

        const SizedBox(height: 4),
        Text(widget.jadwalShalat!,
            style: defaultText.copyWith(
                fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 6),
        Text(ConvertTime.hari(DateFormat('E').format(DateFormat('yyyy-MM-dd')
                .parse(widget.modelShalat!.results!
                    .datetime![(DateTime.now().day) - 1].date!.gregorian!))) +
            ', ' +
            DateFormat('dd MMMM yyyy')
                .format(DateFormat('yyyy-MM-dd').parse(widget
                    .modelShalat!
                    .results!
                    .datetime![(DateTime.now().day) - 1]
                    .date!
                    .gregorian!))
                .toString()),
        const SizedBox(height: 4),
        Container(
          margin: const EdgeInsets.only(top: 6),
          padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.deepPurple[300]!)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.locationDot,
                size: 12,
                color: Colors.deepPurple[300],
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                '${widget.location!.replaceAll(RegExp(r'Kecamatan'), '')}, ${widget.city!.replaceAll(RegExp(r'Kabupaten'), 'Kab.')}',
                style: defaultText.copyWith(
                  fontSize: 11,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  List<Widget> itemsPage() {
    ShalatDate timeShalat =
        widget.modelShalat!.results!.datetime![indexPage - 1].date!;

    DateTime dateFormat = DateFormat('yyyy-MM-dd').parse(timeShalat.gregorian!);

    return widget.modelShalat!.results!.datetime!.map((e) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Text(
            '${ConvertTime.hari(DateFormat('E').format(dateFormat))}, ${DateFormat('dd-MM-yyyy').format(dateFormat)}'),
      );
    }).toList();
  }

  Widget shalatTile() {
    ShalatTimes shalatTime =
        widget.modelShalat!.results!.datetime![indexPage - 1].times!;

    return Column(children: [
      ListTile(
        leading: Icon(
          CommunityMaterialIcons.weather_night_partly_cloudy,
          color: Colors.deepPurple[300],
        ),
        title: const Text('Imsak'),
        trailing: Text(shalatTime.imsak!),
        tileColor: shalatColor == 1 ? Colors.deepPurple[50] : null,
      ),
      ListTile(
        leading: Icon(
          Icons.cloudy_snowing,
          color: Colors.deepPurple[300],
        ),
        title: const Text('Subuh'),
        trailing: Text(shalatTime.fajr!),
        tileColor: shalatColor == 2 ? Colors.deepPurple[50] : null,
      ),
      ListTile(
        leading: Icon(
          CommunityMaterialIcons.weather_sunset,
          color: Colors.deepPurple[300],
        ),
        title: const Text('Terbit'),
        trailing: Text(shalatTime.sunrise!),
        tileColor: shalatColor == 3 ? Colors.deepPurple[50] : null,
      ),
      ListTile(
        leading: Icon(
          CommunityMaterialIcons.white_balance_sunny,
          color: Colors.deepPurple[300],
        ),
        title: const Text('Dzuhur'),
        trailing: Text(shalatTime.dhuhr!),
        tileColor: shalatColor == 4 ? Colors.deepPurple[50] : null,
      ),
      ListTile(
        leading: Icon(
          FontAwesomeIcons.cloudSun,
          color: Colors.deepPurple[300],
        ),
        title: const Text('Ashar'),
        trailing: Text(shalatTime.asr!),
        tileColor: shalatColor == 5 ? Colors.deepPurple[50] : null,
      ),
      ListTile(
        leading: Icon(
          LineIcons.sun,
          color: Colors.deepPurple[300],
        ),
        title: const Text('Terbenam'),
        trailing: Text(shalatTime.sunset!),
        tileColor: shalatColor == 6 ? Colors.deepPurple[50] : null,
      ),
      ListTile(
        leading: Icon(
          Icons.sunny,
          color: Colors.deepPurple[300],
        ),
        title: const Text('Magrib'),
        trailing: Text(shalatTime.maghrib!),
        tileColor: shalatColor == 7 ? Colors.deepPurple[50] : null,
      ),
      ListTile(
        leading: Icon(
          Icons.sunny,
          color: Colors.deepPurple[300],
        ),
        title: const Text('Isya'),
        trailing: Text(shalatTime.isha!),
        tileColor: shalatColor == 8 ? Colors.deepPurple[50] : null,
      ),
      ListTile(
        leading: Icon(
          Icons.sunny,
          color: Colors.deepPurple[300],
        ),
        title: const Text('Tengah malam'),
        trailing: Text(shalatTime.midnight!),
        tileColor: shalatColor == 9 ? Colors.deepPurple[50] : null,
      ),
    ]);
  }
}
