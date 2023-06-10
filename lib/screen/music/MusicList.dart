import 'package:flutter/material.dart';
import 'package:open_music/screen/music/widget/MiniPlayer.dart';
import 'package:open_music/screen/music/widget/Tracks.dart';
import 'package:provider/provider.dart';
import '../../MyAppState.dart';
import '../../model/Music.dart';

class MusicList extends StatelessWidget{
  final Future<List<Music>> Function() getAllMusic;

  const MusicList({super.key, required this.getAllMusic});

  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Open music"),
      ),
      body: Stack(
        children: [
          Track(getAllMusic: getAllMusic,),
          MiniPlayer(appState: appState),
        ],
      )
    );
  }
  
}
