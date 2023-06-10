import 'package:flutter/material.dart';
import '../../../MyAppState.dart';
import '../../../utils/Image.dart';
import '../../../utils/Title.dart';
import '../Player.dart';
import '../Services/PlayerManager.dart';
import 'MusicControl.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    super.key,
    required this.appState,
  });

  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Visibility(
        visible: appState.getPlayerManager()!=null,
        child:GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) {
                  return Player(playerManager: appState.getPlayerManager()!,);
                }),
              );
            },
            child:appState.getPlayerManager()!=null? Card(
              shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              color: Theme.of(context).colorScheme.inversePrimary,
              child: ValueListenableBuilder<CurrentMusicState>(
                valueListenable: appState.getPlayerManager()!.currentMusicNotifier,
                builder: (BuildContext context, CurrentMusicState value, Widget? child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: Card(
                          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.grey,
                          child: ShowNetWorkImage(thumbnail: value.music.thumbnail,),
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width*97)/100-70,
                        child:Center(
                          child: Column(
                            children: [
                              OverflowTitle(
                                text: value.music.title,
                                titleStyle: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                              MusicControl(playerManager: appState.getPlayerManager()!),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ) : Container(),
        ),
      ),
    );
  }
}