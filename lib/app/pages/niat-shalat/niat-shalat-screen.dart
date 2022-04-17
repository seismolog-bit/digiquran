import 'dart:convert';

import 'package:digiquran/app/pages/niat-shalat/niat-salat-view.dart';
import 'package:digiquran/app/widget/image-number.dart';
import 'package:digiquran/utils/text-style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:digiquran/utils/models/niat-shalat/niat-shalat-list.dart';
import 'package:digiquran/utils/models/niat-shalat/niat-shalat.dart';

class NiatShalatScreen extends StatefulWidget {
  const NiatShalatScreen({Key? key}) : super(key: key);

  @override
  State<NiatShalatScreen> createState() => _NiatShalatScreenState();
}

class _NiatShalatScreenState extends State<NiatShalatScreen> {
  final _hive = Hive.box('data');

  List<ModelNiatShalatList>? shalats = [];

  // @override
  // void dispose() {
  //   super.dispose();
  //   _hive.close();
  // }

  Future<bool> _getData() async {
    try {
      ModelNiatShalat? _cacheShalat = await _hive.get('niat-shalat');

      if (_cacheShalat == null || _cacheShalat.data!.isEmpty) {
        final _data = await rootBundle
            .loadString('assets/data/features/niat-sholat.json');
        await _hive.put(
            'niat-shalat', ModelNiatShalat.fromJson(jsonDecode(_data)));

        ModelNiatShalat res = ModelNiatShalat.fromJson(jsonDecode(_data));

        setState(() {
          shalats = res.data;
        });

        print('Data stored');
      } else {
        setState(() {
          shalats = _cacheShalat.data;
        });
      }

      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Niat Shalat'),
      ),
      body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (shalats!.isEmpty) {
                return const Center(
                  child: Text('Data tidak ditemukan'),
                );
              } else {
                return dataList();
              }
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          }),
    );
  }

  Widget dataList() {
    return ListView.builder(
        itemCount: shalats!.length,
        itemBuilder: (context, i) {
          ModelNiatShalatList shalat = shalats![i];
          return ListTile(
            leading: ImageNumber(
                number: (i + 1).toString(),
                style: defaultText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                )),
            title: Text(shalat.name!),
            trailing: const Icon(FontAwesomeIcons.angleRight),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NiatShalatView(
                          shalat: shalat,
                        ))),
          );
        });
  }
}
