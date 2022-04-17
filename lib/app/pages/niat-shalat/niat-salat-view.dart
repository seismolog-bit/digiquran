import 'package:digiquran/utils/text-style.dart';
import 'package:flutter/material.dart';
import 'package:digiquran/utils/models/niat-shalat/niat-shalat-list.dart';

class NiatShalatView extends StatelessWidget {
  final ModelNiatShalatList? shalat;
  const NiatShalatView({Key? key, this.shalat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shalat!.name!),
      ),
      body: ListTile(
        title: Text(
          shalat!.arab!,
          textDirection: TextDirection.rtl,
          style: defaultQuran,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Text(
              shalat!.latin!,
              style: defaultLatin,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              shalat!.means!,
            )
          ],
        ),
      ),
    );
  }
}
