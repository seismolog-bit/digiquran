import 'package:digiquran/utils/models/doa/doa-list.dart';
import 'package:digiquran/utils/text-style.dart';
import 'package:flutter/material.dart';

class DoaView extends StatelessWidget {
  final ModelDoaList? doa;
  const DoaView({Key? key, this.doa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doa!.doa!),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              doa!.ayat!,
              textDirection: TextDirection.rtl,
              style: defaultQuran,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12,),
                Text(
                  doa!.latin!,
                  style: defaultLatin,
                ),
                SizedBox(height: 8,),
                Text(
                  doa!.artinya!,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
