import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';

import '../../model/Music.dart';

class StorageService {
  static String _filename = "open_music.json";
  static String _favoriteKey = "favorite";
  static String _brightnessKey = "brightness";
  static String _languageKey = "language";
  static LocalStorage _storage = LocalStorage(_filename);
  static final favoriteChange = ValueNotifier(true);

  static Future<void> toggleMusicInFavorite(Music music) async {
    await _storage.ready;
    List<dynamic> items = await _storage.getItem(_favoriteKey) ?? [];

    List<Music> musicList = items.map((item) => Music.fromMap(item)).toList();
    if (musicList.contains(music)) {
      musicList.remove(music);
    } else {
      musicList.add(music);
    }
    items = musicList.map((music) => music.toMap()).toList();
    await _storage.setItem(_favoriteKey, items);
    favoriteChange.value = !favoriteChange.value;
  }

  static Future<List<Music>> getAllFavoriteMusic() async {
    await _storage.ready;
    List items = await _storage.getItem(_favoriteKey) ?? [];
    final List<Music> musicList = await items.map((item) => Music.fromMap(item)).toList();
    return musicList;
  }

  static Future<bool> isMusicInFavorite(Music music) async{
    final List<Music> musicList = await getAllFavoriteMusic();
    return musicList.contains(music);
  }

  static Future<void> setBrightness(String brightness) async{
    await _storage.ready;
    await _storage.setItem(_brightnessKey, brightness);
  }

  static Future<String> getBrightness() async{
    await _storage.ready;
    String brightness = await _storage.getItem(_brightnessKey) ?? "";
    return brightness;
  }

  static Future<void> setLanguage(String language) async{
    await _storage.ready;
    await _storage.setItem(_languageKey, language);
  }

  static Future<String> getLanguage() async{
    await _storage.ready;
    String language = await _storage.getItem(_languageKey) ?? "";
    return language;
  }

}