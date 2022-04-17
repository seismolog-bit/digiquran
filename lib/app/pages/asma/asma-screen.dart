import 'dart:convert';

import 'package:digiquran/utils/models/asmaul-husna/asmaul-husna-list.dart';
import 'package:digiquran/utils/models/asmaul-husna/asmaul-husna.dart';
import 'package:digiquran/utils/text-style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class AsmaScreen extends StatefulWidget {
  const AsmaScreen({Key? key}) : super(key: key);

  @override
  State<AsmaScreen> createState() => _AsmaScreenState();
}

class _AsmaScreenState extends State<AsmaScreen> {
  final _hive = Hive.box('data');

  List<ModelAsmaulHusnaList>? asmas = [];

  Future<bool> _getData() async {
    try {
      ModelAsmaulHusna? _cacheAsma = await _hive.get('asma');

      if (_cacheAsma == null || _cacheAsma.data!.isEmpty) {
        final _data = await rootBundle
            .loadString('assets/data/features/asmaul-husna.json');
        await _hive.put('asma', ModelAsmaulHusna.fromJson(jsonDecode(_data)));

        ModelAsmaulHusna res = ModelAsmaulHusna.fromJson(jsonDecode(_data));

        setState(() {
          asmas = res.data;
        });

        print('Data stored');
      } else {
        setState(() {
          asmas = _cacheAsma.data;
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
          title: Text('Asmaul Husna'),
        ),
        body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (asmas!.isEmpty) {
                return const Center(child: Text('Data tidak ditemukan'));
              } else {
                return ListView.builder(
                  itemBuilder: (context, i) {
                    ModelAsmaulHusnaList asma = asmas![i];
                    return Container(
                      // margin: EdgeInsets.fromLTRB((i%2 == 0) ? 16 : 8, (i%2 == 0) ? 8 : 16, 16, 0),E
                      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.deepPurple)),
                      child: ListTile(
                        leading: Text((i + 1).toString()),
                        title: Text(
                          asma.arab!,
                          style: defaultQuran,
                          // textAlign: TextAlign.center,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              asma.latin!,
                              style: defaultLatin,
                              // textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              asma.arti!,
                              // ??textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        tileColor: Colors.transparent,
                      ),
                    );
                  },
                  itemCount: asmas!.length,
                );
              }
            } else {
              return const Center(child: CupertinoActivityIndicator());
            }
          },
        ));
  }
}
