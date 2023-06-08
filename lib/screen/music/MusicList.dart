import 'package:flutter/material.dart';
import 'package:open_music/main.dart';
import 'package:open_music/screen/music/Track.dart';
import 'package:provider/provider.dart';
import '../../model/Music.dart';
import '../utils/Image.dart';
import '../utils/Title.dart';
import 'Player.dart';

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
      body: Track(getAllMusic: getAllMusic,),
      floatingActionButton: FractionallySizedBox(
        widthFactor: appState.getPlayerManager()!=null? 0.9 : 0,
        child: FloatingActionButton(
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) {
                return Player(playerManager: appState.getPlayerManager()!,);
              }),
            );
          },
          child: Visibility(
            visible: appState.getPlayerManager()!=null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Card(
                    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    color: Colors.grey,
                    child: ShowNetWorkImage(thumbnail: appState.getPlayerManager()?.getCurrentMusic().thumbnail??'',),
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width*90)/100-70,
                  child: OverflowTitle(
                    text: appState.getPlayerManager()?.getCurrentMusic().title??"",
                    musicTitleStyle: TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
