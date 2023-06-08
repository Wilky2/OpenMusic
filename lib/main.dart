import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:open_music/HTLocalization.dart';
import 'package:open_music/screen/home.dart';
import 'package:open_music/screen/music/PlayerManager.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          supportedLocales: [Locale('en'),Locale('ht')],
          path: 'assets/translations',
          startLocale: Locale("ht"),
          child: ChangeNotifierProvider(
              create: (BuildContext context) => MyAppState(),
              child: MyApp()
          )
      )
  );
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

  PlayerManager? _playerManager;

  Brightness _brightness=Brightness.light;

  Brightness getBrightnessMode(){
    return _brightness;
  }

  void setBrightnessMode({brightnessMode}){
    _brightness = brightnessMode;
    notifyListeners();
  }

  PlayerManager? getPlayerManager(){
    return _playerManager;
  }

  void setPlayerManager(PlayerManager playerManager){
    _playerManager = playerManager;
    notifyListeners();
  }

}
