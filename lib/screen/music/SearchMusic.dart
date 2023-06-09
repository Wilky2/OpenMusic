

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:open_music/data/api/ApiService.dart';
import 'package:open_music/screen/music/MusicList.dart';

import '../utils/Text.dart';

class SearchMusic extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppText.Search).tr(),
      content: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: AppText.Enteryoursearchquery.tr(),
        ),
      ),
      actions: [
        TextButton(
          child: Text(AppText.Cancel).tr(),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: Text(AppText.Search).tr(),
          onPressed: () {
            String query = _searchController.text;
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
                builder:(ctx)=>MusicList(getAllMusic:(){return APIService.searchMusic(query);})
            ));
          },
        ),
      ],
    );
  }
}