import 'package:flutter/cupertino.dart';
import 'package:open_music/screen/music/Services/PlayerManager.dart';
import 'data/local/Storage.dart';

class MyAppState extends ChangeNotifier {

  MyAppState(){
    _upLoadBrightness();
    _upLoadLanguage();
  }

  PlayerManager? _playerManager;

  Brightness _brightness=Brightness.light;
  Locale _language = Locale("ht");

  static const _light = "light";
  static const _dark = "dark";

  Brightness getBrightnessMode(){
    return _brightness;
  }

  void setBrightnessMode(Brightness brightnessMode) async{
    _brightness = brightnessMode;
    await StorageService.setBrightness(_brightness==Brightness.light?_light:_dark);
    notifyListeners();
  }

  PlayerManager? getPlayerManager(){
    return _playerManager;
  }

  void setPlayerManager(PlayerManager playerManager){
    _playerManager = playerManager;
    notifyListeners();
  }

  Locale getLanguage(){
    return _language;
  }

  void setLanguage(Locale language) async{
    _language = language;
    await StorageService.setLanguage(_language.toString());
    notifyListeners();
  }

  void _upLoadLanguage() async{
    String language = await StorageService.getLanguage();
    setLanguage(Locale(language));
  }

  void _upLoadBrightness() async{
    String brightness = await StorageService.getBrightness();
    setBrightnessMode(brightness == _dark ? Brightness.dark : Brightness.light);
  }

}