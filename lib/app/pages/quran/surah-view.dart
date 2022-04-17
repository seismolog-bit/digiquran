import 'package:digiquran/app/widget/image-number.dart';
import 'package:digiquran/utils/models/list-surah.dart';
import 'package:digiquran/utils/models/settings.dart';
import 'package:digiquran/utils/convert-arabic-number.dart';
import 'package:digiquran/utils/text-style.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class SurahViewScreen extends StatelessWidget {
  final ModelListSurah? listSurah;
  final ModelSettings settings;
  const SurahViewScreen({
    Key? key,
    required this.listSurah,
    required this.settings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String type;

    if (listSurah!.typeId == 'Mekah') {
      type = 'Makkiyah';
    } else {
      type = 'Madaniyah';
    }

    if (kIsWeb) {
      settings.latin = true;
      settings.translate = true;
      settings.line = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          listSurah!.name!,
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 6, 16, 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('assets/background-quran.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20)),
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listSurah!.name!,
                  style: defaultText.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Text(
                  listSurah!.translationId!,
                  style: defaultText.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 1,
                  width: 125,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                Text(
                  '$type - ${listSurah!.numberOfAyahs!} ayat',
                  style: defaultText.copyWith(
                    color: Colors.white60,
                    // fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          (listSurah!.quranNumber == 1)
              ? const SizedBox()
              : Center(
                  child: Text(
                    "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                    style: defaultQuran.copyWith(
                      color: Colors.deepPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
          const SizedBox(height: 12),
          (!settings.latin! && !settings.translate! && settings.line!)
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: lineAyat(),
                )
              : Column(
                  children: listSurah!.text!
                      .map((item) => ListTile(
                            title: RichText(
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                  style: defaultQuran,
                                  text: item.ayahText!,
                                  children: [
                                    WidgetSpan(
                                      child: ImageNumber(
                                        number:
                                            convertArabicNumber(item.verseId!),
                                        style: defaultText.copyWith(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                            subtitle: Column(
                              children: [
                                !settings.latin!
                                    ? const SizedBox()
                                    : Container(
                                        margin: const EdgeInsets.only(
                                            top: 12, bottom: 8),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          item.readText!,
                                          style: defaultLatin,
                                        ),
                                      ),
                                !settings.translate!
                                    ? const SizedBox()
                                    : Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 8),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          item.indoText!,
                                        ),
                                      ),
                                const Divider()
                              ],
                            ),
                          ))
                      .toList())
        ],
      ),
    );
  }

  Widget lineAyat() {
    return RichText(
        textDirection: TextDirection.rtl,
        text: TextSpan(
            children: listSurah!.text!.map((item) {
          return TextSpan(children: [
            TextSpan(children: [
              TextSpan(
                text: item.ayahText!,
                style: defaultQuran,
              ),
              TextSpan(
                text: '  •${convertArabicNumber(
                  item.verseId!,
                )}•  ',
                style: defaultQuran.copyWith(color: Colors.deepPurple),
              )
            ])
          ]);
        }).toList()));
  }
}
