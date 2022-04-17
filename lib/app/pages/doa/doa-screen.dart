import 'dart:convert';

import 'package:digiquran/app/pages/doa/doa-view.dart';
import 'package:digiquran/app/widget/image-number.dart';
import 'package:digiquran/utils/models/doa/doa-list.dart';
import 'package:digiquran/utils/models/doa/doa.dart';
import 'package:digiquran/utils/text-style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({Key? key}) : super(key: key);

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  final _hive = Hive.box('data');

  List<ModelDoaList>? doas = [];

  @override
  void initState() {
    // _getData();
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _hive.close();
  // }

  Future<bool> _getData() async {
    try {
      ModelDoa? _cacheList = await _hive.get('doa');

      if (_cacheList == null || _cacheList.data!.isEmpty) {
        ModelDoa data = await putData();

        if (mounted) {
          setState(() {
            doas = data.data;
          });
        }

        print('doa stored');
      } else {
        setState(() {
          doas = _cacheList.data;
        });
      }

      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }

  Future<ModelDoa> putData() async {
    final data = await rootBundle.loadString('assets/data/features/doa.json');

    await _hive.put('doa', ModelDoa.fromJson(jsonDecode(data)));

    return ModelDoa.fromJson(jsonDecode(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doa Harian'),
      ),
      body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (doas!.isEmpty) {
                return const Text('Data tidak ditemukan');
              } else {
                return ListView.builder(
                  itemBuilder: (context, i) {
                    ModelDoaList doa = doas![i];
                    return ListTile(
                      leading: ImageNumber(
                        number: (i + 1).toString(),
                        style: defaultText.copyWith(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(FontAwesomeIcons.angleRight),
                      title: Text(doa.doa!),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoaView(
                                    doa: doa,
                                  ))),
                    );
                  },
                  itemCount: doas!.length,
                );
              }
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          }),
    );
  }
}
