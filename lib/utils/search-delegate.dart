import 'package:digiquran/utils/models/list-surah.dart';
import 'package:digiquran/utils/models/settings.dart';
import 'package:digiquran/utils/models/surah.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends SearchDelegate<int> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(FontAwesomeIcons.xmark))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(FontAwesomeIcons.angleLeft));
  }

  late int selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(child: Text(selectedResult.toString())),
    );
  }

  final List<ModelListSurah>? list;
  Search(this.list);

  List<ModelListSurah> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ModelListSurah> suggestionList = [];

    query.isEmpty
        ? suggestionList = recentList
        : suggestionList.addAll(list!.where(
            (element) => element.name!.contains(RegExp(query, caseSensitive: false)),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(suggestionList[i].name!),
          trailing: SizedBox(
            height: 32,
            child: Image.asset(
              'assets/surat/sname_${suggestionList[i].quranNumber!}.png',
            ),
          ),
          onTap: () {
            selectedResult = suggestionList[i].quranNumber!;
            Navigator.pop(context, selectedResult);
          },
        );
      }
    );
  }
}
