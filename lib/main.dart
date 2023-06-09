import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:open_music/HTLocalization.dart';
import 'package:open_music/data/local/Storage.dart';
import 'package:open_music/screen/home.dart';
import 'package:open_music/screen/music/PlayerManager.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      ChangeNotifierProvider(
          create: (BuildContext context) => MyAppState(),
          child: EasyLocalizationApp()
      )
  );
}

class EasyLocalizationApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    return EasyLocalization(
        supportedLocales: [Locale('en'),Locale('ht')],
        path: 'assets/translations',
        startLocale: appState.getLanguage(),
        child: MyApp()
    );
  }

}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Open music',
      localizationsDelegates: [
        EasyLocalization.of(context)!.delegate,
        GlobalMaterialLocalizations.delegate,
        HTLocalizationsDelegate(),
        HTLocalizationsDelegateC(),
      ],
      supportedLocales: context.supportedLocales,
      locale: EasyLocalization.of(context)!.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,brightness: appState.getBrightnessMode()),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Open Music'),
    );
  }
}


class MyAppState extends ChangeNotifier {

  MyAppState(){
    _upLoadBrightness();
    _upLoadLanguage();
  }

  PlayerManager? _playerManager;

  Brightness _brightness=Brightness.light;
  Locale _language = Locale("ht");

  static const light = "light";
  static const dark = "dark";
  static const english = "en";
  static const creole = "ht";

  Brightness getBrightnessMode(){
    return _brightness;
  }

  void setBrightnessMode(Brightness brightnessMode){
    _brightness = brightnessMode;
    StorageService.setBrightness(_brightness==Brightness.light?light:dark);
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

  void setLanguage(Locale language){
    _language = language;
    StorageService.setLanguage(_language==Locale("en")?english:creole);
    notifyListeners();
  }

  void _upLoadLanguage() async{
    String language = await StorageService.getLanguage();
    setLanguage(language == english ? Locale("en") : Locale("ht"));
  }

  void _upLoadBrightness() async{
    String brightness = await StorageService.getBrightness();
    setBrightnessMode(brightness == dark ? Brightness.dark : Brightness.light);
  }

}
