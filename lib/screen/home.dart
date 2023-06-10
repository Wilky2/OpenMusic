import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:open_music/data/local/Storage.dart';
import 'package:open_music/screen/music/widget/SearchMusic.dart';
import 'package:open_music/utils/Text.dart';
import 'package:open_music/screen/Setting.dart';
import 'package:provider/provider.dart';
import '../MyAppState.dart';
import '../data/api/ApiService.dart';
import 'music/widget/Artist.dart';
import 'music/widget/MiniPlayer.dart';
import 'music/widget/Tracks.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({super.key, required this.title});

  final List<String> tabs = [AppText.Favorite, AppText.Tracks, AppText.Artists];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
          actions: [
            IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SearchMusic();
                    },
                  );
                },
                icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return SettingsPage();
                  })
                );
              },
              icon: Icon(Icons.settings),
            ),
          ],
          bottom: TabBar(
            tabs: tabs.map((tab) =>
                Tab(
                  icon:Icon(getTabIcon(tab)),
                  text: tab.tr(),
                )
            ).toList(),
          ),
        ),
        body:Stack(
          children: [
            TabBarView(
              children: [
                ValueListenableBuilder(
                    valueListenable: StorageService.favoriteChange,
                    builder: (ctx,value,widget)=>Track(key:UniqueKey(),getAllMusic: StorageService.getAllFavoriteMusic)
                ),
                Track(getAllMusic: APIService.getAllMusic,),
                Artist(),
              ],
            ),
            MiniPlayer(appState: appState),
          ]
        ),
      ),
    );
  }

  IconData getTabIcon(String tab) {
    switch (tab) {
      case AppText.Tracks:
        return Icons.library_music;
      case AppText.Favorite:
        return Icons.favorite;
      case AppText.Artists:
        return Icons.album;
      default:
        return Icons.library_music;
    }
  }

}
