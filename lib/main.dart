import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:open_music/HTLocalization.dart';
import 'package:open_music/screen/home.dart';
import 'package:open_music/screen/music/Services/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'MyAppState.dart';

void initialize () async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupServiceLocator();
}

void main() {
  initialize();
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
        HTMaterialLocalizationsDelegate(),
        HTCupertinoLocalizationsDelegate(),
      ],
      supportedLocales: context.supportedLocales,
      locale: EasyLocalization.of(context)!.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,brightness: appState.getBrightnessMode()),
        useMaterial3: true,
      ),
      home: MyHomePage(title: "Open music",),
    );
  }
}


