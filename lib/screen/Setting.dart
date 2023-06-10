import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:open_music/screen/About.dart';
import 'package:open_music/utils/Text.dart';
import 'package:provider/provider.dart';
import '../MyAppState.dart';

class SettingsPage extends StatefulWidget {
  @override
  State createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  String _selectedLanguage = AppText.Creole;

  List<String> _languages = [AppText.English, AppText.Creole];

  void _updateDarkMode(MyAppState appState){
    setState(() {
      _isDarkMode = appState.getBrightnessMode() == Brightness.dark;
    });
  }

  void _updateSelectedLanguage(BuildContext context){
    setState(() {
      _selectedLanguage = context.locale == Locale("en") ? AppText.English : AppText.Creole;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    _updateDarkMode(appState);
    _updateSelectedLanguage(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Open music'),
        actions: [
          TextButton(
            child: Text(
              AppText.About,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
            ).tr(),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return About();
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.Language,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ).tr(),
            Row(
              children: [
                Text(
                    AppText.Choosealanguage,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                ).tr(),
                Spacer(),
                DropdownButton(
                  value: _selectedLanguage,
                  onChanged: (newValue) {
                    setState(() async{
                      _selectedLanguage = newValue!;
                      Locale language = _selectedLanguage == AppText.English ? Locale("en"):Locale("ht");
                      await context.setLocale(language);
                      appState.setLanguage(language);
                    });
                  },
                  items: _languages.map((language) {
                    return DropdownMenuItem(
                      value: language,
                      child: Text(language).tr(),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              AppText.Brightness,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ).tr(),
            SwitchListTile(
              title: Text(
                  AppText.Darkmode,
                  style: TextStyle(
                    fontSize: 16
                  ),
              ).tr(),
              value: _isDarkMode,
              onChanged: (newValue) {
                setState(() {
                  _isDarkMode = newValue;
                  appState.setBrightnessMode(_isDarkMode? Brightness.dark:Brightness.light);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}