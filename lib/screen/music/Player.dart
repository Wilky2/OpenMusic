import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:open_music/screen/music/widget/FavoriteButton.dart';
import 'package:open_music/screen/music/widget/MusicControl.dart';
import 'package:open_music/screen/music/widget/PlayProgressBar.dart';
import 'package:open_music/screen/music/widget/SpeedButton.dart';
import 'package:open_music/utils/Text.dart';
import 'package:open_music/screen/music/AboutPage.dart';
import 'package:provider/provider.dart';
import '../../MyAppState.dart';
import 'package:open_music/utils/Image.dart';
import 'package:open_music/utils/Title.dart';
import 'Services/PlayerManager.dart';

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
                  Flexible(flex: 1000,child: ShowNetWorkImage(thumbnail: value.music.thumbnail)),
                  Spacer(flex: 100,),
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
                  Spacer(flex: 200,),
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
                      SpeedButton(playerManager: widget.playerManager),
                    ],
                  ),
                  PlayProgressBar(playerManager: widget.playerManager),
                  MusicControl(playerManager: widget.playerManager,)
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


