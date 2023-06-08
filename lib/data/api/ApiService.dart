import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../model/Creator.dart';
import '../../model/Music.dart';

class APIService {
  static String _host = "https://api.openverse.engineering/v1";
  static String _endUrl = "format=json&license_type=commercial";
  static final numberOfPage = ValueNotifier<int>(-1);
  static int _pages = 1;
  static int _pagesCreator = 1;

  static Future<dynamic> get(String url) async {
    final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));
    return response;
  }

  static Future<List<Music>> getAllMusic() async{
    int page= Random().nextInt(_pages) + 1;
    dynamic response = await get("$_host/audio/?page=$page&$_endUrl");
    _pages = jsonDecode(response.body)["page_count"];
    return Music.fromJsonList(response.body);
  }

  static Future<List<Creator>> getAllCreator() async{
    List<Music> musicList = await getAllMusic();
    List<Creator> albumList = musicList.map((music) => Creator(
        id:music.id,thumbnail: music.thumbnail, creator: music.creator)).toList();
    albumList = albumList.toSet().toList();
    return albumList;
  }

  static Future<List<Music>> getRelatedCreatorMusic({creator}) async{
    int page= Random().nextInt(_pagesCreator) + 1;
    dynamic response = await get("$_host/audio/${creator.id}/related/?page=$page&$_endUrl");
    _pagesCreator = jsonDecode(response.body)["page_count"];
    return Music.fromJsonList(response.body);
  }

  static Future<List<Music>> searchMusic(String keyword) async{
    dynamic response = await get("$_host/audio/?title=$keyword&$_endUrl");
    return Music.fromJsonList(response.body);
  }

}