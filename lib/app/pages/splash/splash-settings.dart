import 'dart:convert';

import 'package:digiquran/app/widget/image-number.dart';
import 'package:digiquran/utils/models/shalat/shalat.dart';
import 'package:digiquran/utils/models/surah.dart';
import 'package:digiquran/app/pages/main-page.dart';
import 'package:digiquran/utils/api/api-url.dart';
import 'package:digiquran/utils/convert-arabic-number.dart';
import 'package:digiquran/utils/text-style.dart';
import 'package:digiquran/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashSettingsScreen extends StatefulWidget {
  const SplashSettingsScreen({Key? key}) : super(key: key);

  @override
  State<SplashSettingsScreen> createState() => _SplashSettingsScreenState();
}

class _SplashSettingsScreenState extends State<SplashSettingsScreen> {
  bool isLatin = true;
  bool isTranslate = true;
  bool isLine = false;

  bool isLoading = false;
  late Box box;

  @override
  void initState() {
    // _getData();
    super.initState();
  }

  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  Future _openBox() async {
    box = await Hive.openBox('data');
  }

  Future<bool> _getData() async {
    await _openBox();

    try {
      await box.clear();
      final data = await rootBundle.loadString('assets/quran-full.json');
      await box.put('quran', ModelSurah.fromJson(jsonDecode(data)));

      print('quran stored');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void checkToggle() {
    if (isLatin || isTranslate) {
      setState(() {
        isLine = false;
      });
    } else {
      setState(() {
        isLine = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(32, 12, 32, 12),
            child: Column(
              children: [
                Text(
                  'Kustomasi',
                  style: defaultText.copyWith(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  'Atur kebutuhan membaca Al-Quran anda',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.purple,
                  // width: 1
                )),
            child: ListTile(
              title: widgetAyat(),
              subtitle: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  !isLatin
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 8),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'bismillāhir-raḥmānir-raḥīm',
                            style: defaultLatin,
                          ),
                        ),
                  const SizedBox(
                    height: 8,
                  ),
                  !isTranslate
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Dengan nama Allah Yang Maha Pengasih, Maha Penyayang.',
                          ),
                        ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                title: const Text('Transliterasi (Latin)'),
                trailing: Switch(
                    value: isLatin,
                    onChanged: (value) {
                      setState(() {
                        isLatin = value;
                      });

                      checkToggle();
                    }),
              ),
              ListTile(
                title: const Text('Terjemahan'),
                trailing: Switch(
                    value: isTranslate,
                    onChanged: (value) {
                      setState(() {
                        isTranslate = value;
                      });

                      checkToggle();
                    }),
              ),
              ListTile(
                title: const Text('Tampilan penuh'),
                subtitle: const Text('Digunakan hanya untuk tampilan ayat'),
                trailing: Switch(
                    value: isLine,
                    onChanged: (!isLatin && !isTranslate)
                        ? (value) {
                            setState(() {
                              isLine = value;
                            });
                          }
                        : null),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: continueButton(),
    );
  }

  Widget continueButton() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Material(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => finishButton(),
          child: Container(
            width: 162,
            height: 42,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: isLoading
                ? const Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Selesai',
                    style: defaultText.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget widgetAyat() {
    return (!isLatin && !isTranslate && !isLine)
        ? Container(
            width: double.infinity,
            alignment: Alignment.topRight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: defaultQuran,
                        text: "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                      ),
                      WidgetSpan(
                        child: ImageNumber(
                            number: convertArabicNumber(1), style: defaultText),
                      ),
                    ],
                  ),
                ),
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: defaultQuran,
                        text: "اَلْحَمْدُ لِلّٰهِ رَبِّ الْعٰلَمِيْنَۙ",
                      ),
                      WidgetSpan(
                        child: ImageNumber(
                            number: convertArabicNumber(2), style: defaultText),
                      ),
                    ],
                  ),
                ),
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: defaultQuran,
                        text: "الرَّحْمٰنِ الرَّحِيْمِۙ",
                      ),
                      WidgetSpan(
                        child: ImageNumber(
                            number: convertArabicNumber(3), style: defaultText),
                      ),
                    ],
                  ),
                ),
                Text(
                  '...',
                  style: defaultQuran,
                )
              ],
            ),
          )
        : RichText(
            textDirection: TextDirection.rtl,
            text: (isLatin || isTranslate && (!isLine))
                ? TextSpan(
                    children: [
                      TextSpan(
                        style: defaultQuran,
                        text: "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                      ),
                      WidgetSpan(
                        child: ImageNumber(
                            number: convertArabicNumber(1), style: defaultText),
                      ),
                    ],
                  )
                : TextSpan(
                    children: [
                      TextSpan(
                        style: defaultQuran,
                        text: "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                      ),
                      TextSpan(
                          text: '  •${convertArabicNumber(1)}•  ',
                          style: defaultQuran.copyWith(color: Colors.purple)),
                      TextSpan(
                        style: defaultQuran,
                        text: "اَلْحَمْدُ لِلّٰهِ رَبِّ الْعٰلَمِيْنَۙ",
                      ),
                      TextSpan(
                          text: '  •${convertArabicNumber(2)}•  ',
                          style: defaultQuran.copyWith(color: Colors.purple)),
                      TextSpan(
                        style: defaultQuran,
                        text: "الرَّحْمٰنِ الرَّحِيْمِۙ",
                      ),
                      TextSpan(
                          text: '  •${convertArabicNumber(3)}•  ',
                          style: defaultQuran.copyWith(color: Colors.purple)),
                      TextSpan(text: '...', style: defaultQuran)
                    ],
                  ),
          );
  }

  Future _getShalat() async {
    try {
      // var response = await ApiUrl.get('today', -6.4956495, 108.4869557);
      SharedPreferences pref = await SharedPreferences.getInstance();

      // double long = pref.getDouble('longitude')!;

      // ModelShalat res = ModelShalat(response);

      ModelShalat res = ModelShalat.fromJson(await ApiUrl.get('this_month',
          pref.getDouble('latitude')!, pref.getDouble('longitude')!));

      await box.put('shalat', res);

      print('Data stored');

      print(res.results!.datetime!.length);
    } catch (e) {
      print(e);
    }
  }

  Future finishButton() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      isLoading = true;
    });

    await pref.setBool('isLatin', isLatin);
    await pref.setBool('isTranslate', isTranslate);
    await pref.setBool('isLine', isLine);
    await pref.setBool('initScreen', true);

    bool store = await _getData();
    await _getShalat();

    if (store) {
      Toast.show('Data berhasil disimpan');

      setState(() {
        isLoading = false;
      });

      return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false);
    } else {
      Toast.show('Terjadi kesalahan, data gagal disimpan');
      setState(() {
        isLoading = false;
      });

      return;
    }
  }
}
