import 'dart:io';

import 'package:digiquran/utils/models/asmaul-husna/asmaul-husna-list.dart';
import 'package:digiquran/utils/models/asmaul-husna/asmaul-husna.dart';
import 'package:digiquran/utils/models/ayah.dart';
import 'package:digiquran/utils/models/doa/doa-list.dart';
import 'package:digiquran/utils/models/doa/doa.dart';
import 'package:digiquran/utils/models/list-surah.dart';
import 'package:digiquran/utils/models/niat-shalat/niat-shalat.dart';
import 'package:digiquran/utils/models/niat-shalat/niat-shalat-list.dart';
import 'package:digiquran/utils/models/quran/quran.dart';
import 'package:digiquran/utils/models/quran/verse.dart';
import 'package:digiquran/utils/models/shalat/shalat-datetime.dart';
import 'package:digiquran/utils/models/shalat/shalat-result.dart';
import 'package:digiquran/utils/models/shalat/shalat-time.dart';
import 'package:digiquran/utils/models/shalat/shalat-date.dart';
import 'package:digiquran/utils/models/shalat/shalat.dart';
import 'package:digiquran/utils/models/surah.dart';
import 'package:digiquran/app/pages/splash/splash.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/pages/main-page.dart';

bool ? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences pref = await SharedPreferences.getInstance();
  initScreen = pref.getBool('initScreen');
  // await pref.setBool('initScreen', true);

  await Hive.initFlutter();
  //quran
  Hive.registerAdapter(ModelSurahAdapter());
  Hive.registerAdapter(ModelListSurahAdapter());
  Hive.registerAdapter(ModelAyahAdapter());

  //Quran Juz
  Hive.registerAdapter(ModelQuranAdapter());
  Hive.registerAdapter(ModelVerseAdapter());
  
  //doa harian
  Hive.registerAdapter(ModelDoaAdapter());
  Hive.registerAdapter(ModelDoaListAdapter());
  
  //niat shalat
  Hive.registerAdapter(ModelNiatShalatAdapter());
  Hive.registerAdapter(ModelNiatShalatListAdapter());
  
  //asmaul husna
  Hive.registerAdapter(ModelAsmaulHusnaAdapter());
  Hive.registerAdapter(ModelAsmaulHusnaListAdapter());

  // jadwal shalat
  Hive.registerAdapter(ModelShalatAdapter());
  Hive.registerAdapter(ShalatResultAdapter());
  Hive.registerAdapter(ShalatDatetimeAdapter());
  Hive.registerAdapter(ShalatDateAdapter());
  Hive.registerAdapter(ShalatTimesAdapter());

  await Hive.openBox('data');

  // await initializeDateFormatting('id_ID').then((_) => runApp(MyApp()));
  // await initializeDateFormatting(locale, filePath)
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    if(kIsWeb){
      initScreen = true;
    }

    return MaterialApp(
      title: 'DigiQuran',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            fontSize: 23,
            fontFamily: 'Overpass'
          ),
          iconTheme: IconThemeData(color: Colors.deepPurple),
          actionsIconTheme: IconThemeData(
            color: Colors.deepPurple
          ), 
        ),
        fontFamily: 'Overpass'
      ),
      home: initScreen == null ? const SplashScreen() : const MainScreen(),
    );
  }
}
