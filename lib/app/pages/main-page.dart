import 'dart:async';
import 'dart:convert';

import 'package:digiquran/app/widget/image-number.dart';
import 'package:digiquran/utils/models/list-surah.dart';
import 'package:digiquran/utils/models/settings.dart';
import 'package:digiquran/utils/models/shalat/shalat-time.dart';
import 'package:digiquran/utils/models/shalat/shalat.dart';
import 'package:digiquran/app/pages/asma/asma-screen.dart';
import 'package:digiquran/app/pages/doa/doa-screen.dart';
import 'package:digiquran/app/pages/home/carousel-shalat.dart';
import 'package:digiquran/app/pages/niat-shalat/niat-shalat-screen.dart';
import 'package:digiquran/app/pages/shalat/shalat.dart';
import 'package:digiquran/app/pages/quran/surah-view.dart';
import 'package:digiquran/utils/bubble-tab-indicator.dart';
import 'package:digiquran/utils/text-style.dart';
import 'package:digiquran/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/utils/models/surah.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late Box box;
  final _hive = Hive.box('data');
  bool _isLoading = true;
  List<ModelListSurah>? surahs = [];

  late ModelSettings settings;
  late ModelShalat? shalat;
  late String _location;
  late String _city;
  // late ShalatTimes time;

  late TabController _tabController;

  late String _timeString;

  late IntShalatTime _intShalatTime;
  late ShalatTimes _shalatTimes;
  String _jadwalShalat = '';

  // Countdown
  bool isRunning = false;
  late CountdownController countdownController;
  Duration _duration = Duration(seconds: 0);

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    _getShalat();
    _getSettings().then((value) {});

    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    countdownController.dispose();
    super.dispose();
  }

  Future _getShalat() async {
    try {
      ModelShalat? _cacheShalat = await _hive.get('shalat');
      setState(() {
        shalat = _cacheShalat!;
      });
    } catch (e) {
      print(e);
    }
  }

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Surah'),
    Tab(text: 'Juz'),
    Tab(text: 'Riwayat'),
  ];

  Future _getSettings() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int timeNow =
          ConvertTime.timeToInt(ConvertTime.getTime(ConvertTime.time_3));

      DateTime now = DateTime.now();

      ShalatTimes shalatTime =
          shalat!.results!.datetime![(DateTime.now().day) - 1].times!;

      IntShalatTime intShalatTime = IntShalatTime(
        imsak: ConvertTime.timeToInt(shalatTime.imsak!),
        sunrise: ConvertTime.timeToInt(shalatTime.sunrise!),
        fajr: ConvertTime.timeToInt(shalatTime.fajr!),
        dhuhr: ConvertTime.timeToInt(shalatTime.dhuhr!),
        asr: ConvertTime.timeToInt(shalatTime.asr!),
        sunset: ConvertTime.timeToInt(shalatTime.sunset!),
        maghrib: ConvertTime.timeToInt(shalatTime.maghrib!),
        isha: ConvertTime.timeToInt(shalatTime.isha!),
        midnight: ConvertTime.timeToInt(shalatTime.midnight!),
      );

      setState(() {
        _shalatTimes = shalatTime;
        _intShalatTime = intShalatTime;

        _location = pref.getString('location')!;
        _city = pref.getString('city')!;
        settings = ModelSettings(
            latin: pref.getBool('isLatin'),
            translate: pref.getBool('isTranslate'),
            line: pref.getBool('isLine'));

        if (timeNow < intShalatTime.imsak! ||
            timeNow >= intShalatTime.midnight!) {
          _jadwalShalat = 'Imsak ${shalatTime.imsak!}';
          _duration = Duration(minutes: (intShalatTime.imsak!) - timeNow, seconds: now.second);
        } else if (timeNow >= intShalatTime.imsak! &&
            timeNow < intShalatTime.fajr!) {
          _jadwalShalat = 'Subuh ${shalatTime.fajr!}';
          _duration = Duration(minutes: (intShalatTime.fajr!) - timeNow, seconds: now.second);
        } else if (timeNow >= intShalatTime.fajr! &&
            timeNow < intShalatTime.dhuhr!) {
          _jadwalShalat = 'Dzuhur ${shalatTime.dhuhr!}';
          _duration = Duration(minutes: (intShalatTime.dhuhr!) - timeNow, seconds: now.second);
        } else if (timeNow >= intShalatTime.dhuhr! &&
            timeNow < intShalatTime.asr!) {
          _jadwalShalat = 'Ashar ${shalatTime.asr!}';
          _duration = Duration(minutes: (intShalatTime.asr!) - timeNow, seconds: now.second);
        } else if (timeNow >= intShalatTime.asr! &&
            timeNow < intShalatTime.maghrib!) {
          _jadwalShalat = 'Magrib ${shalatTime.maghrib!}';
          _duration = Duration(minutes: (intShalatTime.maghrib!) - timeNow, seconds: now.second);
        } else if (timeNow >= intShalatTime.maghrib! &&
            timeNow < intShalatTime.isha!) {
          _jadwalShalat = 'Isya ${shalatTime.isha!}';
          _duration = Duration(minutes: intShalatTime.isha!, seconds: now.second);
        } else {
          _jadwalShalat = 'Tegah Malam ${shalatTime.midnight!}';
          _duration = Duration(minutes: intShalatTime.midnight!, seconds: now.second);
        }
      });

      print("Durasi:  $_duration");

      countdownController = CountdownController(duration: _duration);

      countdownController.start();
    } catch (e) {
      print('Error _getSetting $e');
    }
  }

  Future _openBox() async {
    box = await Hive.openBox('data');

    return;
  }

  Future<bool> _getSurah() async {
    await _openBox();
    try {
      ModelSurah? _modelSurah = await box.get('quran');

      if (_modelSurah == null || _modelSurah.features!.isEmpty) {
        ModelSurah surah = await putData();

        if (mounted) {
          setState(() {
            surahs = surah.features;
          });
        }

        print('success stored: ${surahs?.length}');
      } else {
        setState(() {
          surahs = _modelSurah.features;
        });
      }
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<ModelSurah> putData() async {
    await box.clear();
    final data = await rootBundle.loadString('assets/quran-full.json');
    await box.put('quran', ModelSurah.fromJson(jsonDecode(data)));
    return ModelSurah.fromJson(jsonDecode(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('DigiQuran'),
      //   actions: [
      //     IconButton(
      //       onPressed: () async {
      //         int? num =
      //             await showSearch(context: context, delegate: Search(surahs));
      //         if (num != null) {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => SurahViewScreen(
      //                         listSurah: surahs![num - 1],
      //                         settings: settings,
      //                       )));
      //         } else {
      //           return;
      //         }
      //       },
      //       icon: const Icon(FeatherIcons.search),
      //     )
      //   ],
      // ),
      body: _isLoading
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Stack(
                  children: [
                    const SizedBox(
                      height: 276,
                      width: double.infinity,
                    ),
                    Container(
                      height: 234,
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
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 72,
                          ),
                          // Text(shalat!.results!.datetime![0].date!.gregorian!)

                          Countdown(
                            countdownController: countdownController,
                            builder: (_, timer) {
                              if (timer.isNegative) {
                                return const Text('Berlangsung');
                              } else {
                                return Text(
                                    '- ${timer.inHours.bitLength} : ${timer.inMinutes % 60} : ${timer.inSeconds % 60}');
                              }
                            },
                          ),
                          const SizedBox(height: 4),
                          Text(_jadwalShalat,
                              style: defaultText.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          const SizedBox(height: 6),

                          Text(ConvertTime.hari(DateFormat('E').format(
                                  DateFormat('yyyy-MM-dd').parse(shalat!
                                      .results!
                                      .datetime![(DateTime.now().day) - 1]
                                      .date!
                                      .gregorian!))) +
                              ', ' +
                              DateFormat('dd MMMM yyyy')
                                  .format(DateFormat('yyyy-MM-dd').parse(shalat!
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
                                border:
                                    Border.all(color: Colors.deepPurple[300]!)),
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
                                  '${_location.replaceAll(RegExp(r'Kecamatan'), '')}, ${_city.replaceAll(RegExp(r'Kabupaten'), 'Kab.')}',
                                  style: defaultText.copyWith(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: CarouselShalat(
                        shalatTimes: shalat!
                            .results!.datetime![DateTime.now().day].times!,
                        intShalatTime: _intShalatTime,
                      ),
                    )
                  ],
                ),
                widgetMenus(),
                const SizedBox(
                  child: Divider(),
                ),
                _tabs(),
                _viewTabs(),
              ],
            ),
    );
  }

  Container _tabs() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: TabBar(
        isScrollable: true,
        unselectedLabelColor: Colors.deepPurple[300],
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(fontSize: 12),
        indicator: const BubbleTabIndicator(
          indicatorHeight: 28.0,
          indicatorColor: Colors.deepPurple,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
        controller: _tabController,
        tabs: myTabs,
      ),
    );
  }

  Center _viewTabs() {
    return Center(
      child: [
        surah(),
        const Center(
          child: Text('Dalam pengembangan'),
        ),
        const Center(
          child: Text('Dalam pengembangan'),
        ),
      ][_tabController.index],
    );
  }

  Widget widgetMenus() {
    Widget menu(String title, String image, Function() onTap) {
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 62,
                  width: 62,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(2, 3),
                            blurRadius: 5)
                      ]),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 42,
                    height: 42,
                    child: Image(
                      image: AssetImage(image),
                    ),
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style:
                      defaultText.copyWith(fontSize: 12, color: Colors.black87),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          menu(
              'Jadwal Shalat',
              'assets/menus/mosque.png',
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShalatScreen(
                            modelShalat: shalat!,
                            jadwalShalat: _jadwalShalat,
                            // timeDuration: _duration,
                            location: _location,
                            city: _city,
                          )))),
          menu('Doa', 'assets/menus/praying.png', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DoaScreen()));
          }),
          menu(
              'Niat Shalat',
              'assets/menus/prayer-rug.png',
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NiatShalatScreen()))),
          menu(
              'Asmaul Husna',
              'assets/menus/night.png',
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AsmaScreen()))),
        ],
      ),
    );
  }

  Widget listSurah() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        ModelListSurah item = surahs![i];
        return ListTile(
          leading: ImageNumber(
            number: item.quranNumber!.toString(),
            style: defaultText.copyWith(
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text(
            item.name!,
          ),
          subtitle: Text(
            item.typeId == 'Mekah'
                ? 'Makkiyah - ${item.numberOfAyahs!} ayat'.toUpperCase()
                : 'Madaniyah - ${item.numberOfAyahs!} ayat'.toUpperCase(),
          ),
          trailing: SizedBox(
            height: 32,
            child: Image.asset(
              'assets/surat/sname_${item.quranNumber}.png',
            ),
          ),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SurahViewScreen(
                        listSurah: item,
                        settings: settings,
                      ))),
        );
      },
      itemCount: surahs!.length,
    );
  }

  Widget surah() {
    return FutureBuilder(
        future: _getSurah(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (surahs!.isEmpty) {
              return const Text('No data');
            } else {
              return listSurah();
              // return SizedBox();
            }
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        });
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
  }

  List<Widget> shalats() {
    return [
      Container(
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 3), color: Colors.black12, blurRadius: 5)
            ]),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       'Time 00:00',
        //       style: defaultText.copyWith(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 20,
        //           color: Colors.deepPurple[400]),
        //     ),
        //     Text(
        //       _timeString,
        //       style: defaultText.copyWith(
        //         color: Colors.grey
        //       ),
        //     )
        //   ],
        // ),
        child: ListTile(
          // leading: Icon(Icons.sunny),
          title: Text(
            'Text Time, 00:00',
            style: defaultText.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.deepPurple,
            ),
            // textAlign: TextAlign.center,
          ),
          subtitle: Text(
            _timeString,
            // textAlign: TextAlign.center,
            style: defaultText.copyWith(color: Colors.grey),
          ),
          trailing: const Icon(Icons.notification_add),
        ),
      ),
    ];
  }
}
