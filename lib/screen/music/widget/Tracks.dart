import 'package:flutter/material.dart';

import '../../../model/Music.dart';
import 'PlayList.dart';

class Track extends StatefulWidget{
  final Future<List<Music>> Function() getAllMusic;

  const Track({super.key,required this.getAllMusic});

  @override
  State<StatefulWidget> createState() {
    return _TrackState();
  }

}

class _TrackState extends State<Track> {
  late Future<List<Music>> Function() getAllMusic;
  late Key _playListKey;

  @override
  void initState(){
    super.initState();
    getAllMusic = widget.getAllMusic;
    _playListKey =UniqueKey();
  }

  void reload() {
    setState(() {
      getAllMusic = widget.getAllMusic;
      _playListKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        await Future.delayed(Duration(seconds: 2));
        reload();
      },
      child:PlayList(getMusicList: getAllMusic,key: _playListKey,),
    );
  }
}