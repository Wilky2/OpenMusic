import 'package:flutter/material.dart';
import '../../../model/Music.dart';
import '../../../utils/Error.dart';
import '../../../utils/Image.dart';
import '../../../utils/Progress.dart';
import '../../../utils/Title.dart';
import '../Player.dart';
import '../Services/PlayerManager.dart';

class PlayList extends StatefulWidget {

  final Future<List<Music>> Function() getMusicList;

  const PlayList({super.key, required this.getMusicList});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {

  late Future<List<Music>> musicList;
  late PlayerManager _playerManager;
  late Key _playListKey;

  @override
  void initState() {
    super.initState();
    musicList = widget.getMusicList();
    _playListKey = UniqueKey();
  }

  void reload() {
    setState(() {
      musicList = widget.getMusicList();
      _playListKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Music>>(
        key: _playListKey,
        future: musicList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Music> data = snapshot.data!;
            _playerManager = PlayerManager(musicList: data);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: snapshot.data!.map((music) =>
                        ElevatedButton(
                            style : ElevatedButton.styleFrom(
                                minimumSize: Size(MediaQuery.of(context).size.width, 70),
                                side: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                                padding: EdgeInsets.all(0),
                                shape : ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0))
                            ),
                            onPressed: (){
                              _playerManager.init(data.indexOf(music));
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (ctx) {
                                  return Player(playerManager: _playerManager,);
                                }),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Card(
                                    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                    color: Colors.grey,
                                    child: ShowNetWorkImage(thumbnail:music.thumbnail,),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width-70,
                                  child: OverflowTitle(
                                    text: music.title,
                                    titleStyle: TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ],
                            )
                        )).toList(),
                  ),
                  SizedBox(height: 70,),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return ShowError(reload: reload, error: snapshot.error.toString(),);
          } else {
            return CircularProgress();
          }
        },
    );
  }
}
