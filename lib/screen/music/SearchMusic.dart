

import 'package:flutter/material.dart';
import 'package:open_music/data/api/ApiService.dart';
import 'package:open_music/screen/music/MusicList.dart';

class SearchMusic extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Search'),
      content: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Enter your search query',
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: Text('Search'),
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