import 'dart:async';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:open_music/data/local/Storage.dart';
import 'package:open_music/screen/utils/Error.dart';
import 'package:open_music/screen/utils/Text.dart';
import 'package:open_music/main.dart';
import 'package:open_music/screen/music/AboutPage.dart';
import 'package:provider/provider.dart';
import '../../model/Music.dart';
import '../utils/Image.dart';
import '../utils/Title.dart';
import 'PlayerManager.dart';

class Player extends StatefulWidget {
  final PlayerManager playerManager;

  const Player({Key? key, required this.playerManager}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {

  double _volume = 0.5;
  bool _isShowSlider = false;

  Timer? _sliderTimer;

  final sliderTimerDuration = Duration(seconds: 60);

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    return WillPopScope(
      onWillPop: () async{
        appState.setPlayerManager(widget.playerManager);
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Open music"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                    return AboutPage(music: widget.playerManager.getCurrentMusic());
                  })
                );
              },
              child: Text(
                AppText.About,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ).tr(),
            ),
          ],
        ),
        body: ValueListenableBuilder<CurrentMusicState>(
          valueListenable: widget.playerManager.currentMusicNotifier,
          builder: (BuildContext context, CurrentMusicState value, Widget? child) {
            return Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  ShowNetWorkImage(thumbnail: value.music.thumbnail),
                  Spacer(),
                  Center(
                    child: OverflowTitle(text: value.music.title),
                  ),
                  Text(
                    value.music.creator,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Visibility(
                    visible: _isShowSlider,
                    child: Slider(
                      min: 0,
                      max: 100,
                      divisions: 10,
                      label: (_volume*100).round().toString(),
                      value: _volume*100,
                      onChanged: (newValue) {
                        setState(() {
                          _volume = newValue/100;
                          widget.playerManager.setVolume(_volume);
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(_volume > 0 ? Icons.volume_up : Icons.volume_off),
                        onPressed: toggleSliderVisibility,
                      ),
                      Spacer(),
                      FavoriteButton(music: value.music),
                      Spacer(),
                      _SpeedButton(playerManager: widget.playerManager),
                    ],
                  ),
                  _PlayProgressBar(playerManager: widget.playerManager),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _ShuffleBtn(playerManager: widget.playerManager),
                      Spacer(),
                      IconButton(
                        onPressed: widget.playerManager.seekToPrevious,
                        icon: Icon(Icons.skip_previous),
                      ),
                      Spacer(),
                      _PlayBtn(playerManager: widget.playerManager),
                      Spacer(),
                      IconButton(
                        onPressed: widget.playerManager.seekToNext,
                        icon: Icon(Icons.skip_next),
                      ),
                      Spacer(),
                      _LoopModeBtn(playerManager: widget.playerManager),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _sliderTimer = Timer(sliderTimerDuration, _hideSlider);
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    super.dispose();
  }

  void _hideSlider(){
    setState(() {
      _isShowSlider = false;
    });
  }

  void _activateTimer() {
    setState(() {
      _sliderTimer = Timer(sliderTimerDuration, _hideSlider);
    });
  }

  void _cancelTimer() {
    setState(() {
      _sliderTimer?.cancel();
    });
  }

  void toggleSliderVisibility() {
    setState(() {
      _isShowSlider = !_isShowSlider;
      if (_isShowSlider) {
        _activateTimer();
      } else {
        _cancelTimer();
      }
    });
  }

}

class _PlayProgressBar extends StatelessWidget {
  const _PlayProgressBar({
    required PlayerManager playerManager,
  }) : _playerManager = playerManager;

  final PlayerManager _playerManager;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _playerManager.progressNotifier,
      builder: (BuildContext context, ProgressBarState value, Widget? child){
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek : _playerManager.seek,
        );
      },
    );
  }
}

class _PlayBtn extends StatelessWidget {

  const _PlayBtn({
    required PlayerManager playerManager,
  }) : _playerManager = playerManager;

  final PlayerManager _playerManager;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PlayingButtonState>(
      valueListenable: _playerManager.playingButtonNotifier,
      builder: (BuildContext context, PlayingButtonState value, Widget? child) {
        switch (value) {
          case PlayingButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: const CircularProgressIndicator(),
            );
          case PlayingButtonState.paused:
            return IconButton(
              icon: const Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: _playerManager.play,
            );
          case PlayingButtonState.playing:
            return IconButton(
              icon: const Icon(Icons.pause),
              iconSize: 32.0,
              onPressed: _playerManager.pause,
            );
        }
      },
    );
  }
}

class _LoopModeBtn extends StatelessWidget {

  const _LoopModeBtn({
    required PlayerManager playerManager,
  }) : _playerManager = playerManager;

  final PlayerManager _playerManager;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LoopMode>(
      valueListenable: _playerManager.loopModeButtonNotifier,
      builder: (BuildContext context, LoopMode value, Widget? child) {
        switch (value) {
          case LoopMode.off:
            return IconButton(
              icon: const Icon(Icons.repeat,color: Colors.grey,),
              iconSize: 32.0,
              onPressed: (){_playerManager.setLoopMode(LoopMode.all);},
            );
          case LoopMode.all:
            return IconButton(
              icon: const Icon(Icons.repeat),
              iconSize: 32.0,
              onPressed: (){_playerManager.setLoopMode(LoopMode.one);},
            );
          case LoopMode.one:
            return IconButton(
              icon: const Icon(Icons.repeat_one),
              iconSize: 32.0,
              onPressed: (){_playerManager.setLoopMode(LoopMode.off);},
            );
        }
      },
    );
  }
}

class _ShuffleBtn extends StatelessWidget {

  const _ShuffleBtn({
    required PlayerManager playerManager,
  }) : _playerManager = playerManager;

  final PlayerManager _playerManager;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _playerManager.shuffleButtonNotifier,
      builder: (BuildContext context, bool value, Widget? child) {
        return value ?
          IconButton(
            icon: const Icon(Icons.shuffle),
            iconSize: 32.0,
            onPressed: (){_playerManager.setShuffleModeEnabled(false);},
          )
         :
         IconButton(
            icon: const Icon(Icons.shuffle,color: Colors.grey,),
            iconSize: 32.0,
            onPressed: (){_playerManager.setShuffleModeEnabled(true);},
         );
      }
    );
  }
}

class _SpeedButton extends StatelessWidget {
  const _SpeedButton({
    required PlayerManager playerManager,
  }) : _playerManager = playerManager;

  final PlayerManager _playerManager;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _playerManager.speedNotifier,
      builder: (BuildContext context, double value, Widget? child) {
        return PopupMenuButton<double>(
          icon: Icon(Icons.speed),
          initialValue: value,
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<double>>[
              PopupMenuItem<double>(
                value: 0.5,
                child: Text('0.5x'),
              ),
              PopupMenuItem<double>(
                value: 1.0,
                child: Text('1.0x'),
              ),
              PopupMenuItem<double>(
                value: 1.5,
                child: Text('1.5x'),
              ),
              PopupMenuItem<double>(
                value: 2.0,
                child: Text('2.0x'),
              ),
            ];
          },
          onSelected: (double newSpeed) {
            _playerManager.setSpeed(newSpeed);
          },
        );
      }
    );
  }
}

class FavoriteButton extends StatefulWidget{

  final Music music;

  const FavoriteButton({super.key,required this.music});

  @override
  State<StatefulWidget> createState() {
    return _FavoriteShoppingButton();
  }
}

class _FavoriteShoppingButton extends State<FavoriteButton>{

  late Future<bool> isFavorite;
  late Key _favoriteKey;

  @override
  void initState() {
    super.initState();
    isFavorite = StorageService.isMusicInFavorite(widget.music);
    _favoriteKey = UniqueKey();
  }

  void reload() {
    setState(() {
      isFavorite = StorageService.isMusicInFavorite(widget.music);
      _favoriteKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder(
            future: isFavorite,
            builder: (context,result){
              if(result.hasData){
                return IconButton(
                  icon: result.data! ? Icon(Icons.favorite,size: 40,) : Icon(Icons.favorite_border,size: 40,),
                  onPressed: () async{
                    await StorageService.toggleMusicInFavorite(widget.music);
                    setState(() {
                      isFavorite = StorageService.isMusicInFavorite(widget.music);
                    });
                  },
                );
              }
              else if(result.hasError){
                return ShowError(reload: reload, error: result.error.toString());
              }
              else{
                return CircularProgressIndicator();
              }
            }
        ),
      ],
    );
  }



}