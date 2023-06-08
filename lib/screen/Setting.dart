import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:open_music/screen/utils/Text.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
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

  void _updadteSelectedLanguage(BuildContext context){
    setState(() {
      _selectedLanguage = context.locale == Locale("en") ? AppText.English : AppText.Creole;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    _updateDarkMode(appState);
    _updadteSelectedLanguage(context);
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
                  return AlertDialog(
                    title: Text('About Open Music'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Open Music - Online Music Platform',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Version: 1.0.0',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Thank you for using Open Music! We strive to provide you with the best music streaming experience. Please read the following terms carefully:',
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            '1. OpenVerse API Terms of Use',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'By using the OpenVerse API, you agree to the API Terms of Use. Make sure to adhere to rate limits, registration requirements, and all other documented conditions.',
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            '2. Use of OpenVerse API',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Open Music utilizes the OpenVerse API to aggregate metadata about openly licensed content from third-party websites. Open Music does not own or control the content or data available through the API. Make sure to independently verify the rights to use the content and data and the applicable terms and conditions.',
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            '3. Copyright Compliance',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Respect copyright of the content accessible via the OpenVerse API. You must provide proper attribution to CC-licensed works and comply with the terms and conditions of platforms hosting those works.',
                          )
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
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
                    setState(() {
                      _selectedLanguage = newValue!;
                      context.setLocale(_selectedLanguage == AppText.English ? Locale("en"):Locale("ht"));
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
                  appState.setBrightnessMode(brightnessMode:_isDarkMode? Brightness.dark:Brightness.light);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}