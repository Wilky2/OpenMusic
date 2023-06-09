import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'PlayerManager.dart';

class MusicControl extends StatelessWidget {
  const MusicControl({
    super.key, required this.playerManager,
  });

  final PlayerManager playerManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShuffleBtn(playerManager: playerManager),
        Spacer(),
        IconButton(
          onPressed: playerManager.seekToPrevious,
          icon: Icon(Icons.skip_previous),
        ),
        Spacer(),
        PlayBtn(playerManager: playerManager),
        Spacer(),
        IconButton(
          onPressed: playerManager.seekToNext,
          icon: Icon(Icons.skip_next),
        ),
        Spacer(),
        LoopModeBtn(playerManager: playerManager),
      ],
    );
  }
}

class PlayBtn extends StatelessWidget {

  const PlayBtn({
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

class LoopModeBtn extends StatelessWidget {

  const LoopModeBtn({
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

class ShuffleBtn extends StatelessWidget {

  const ShuffleBtn({
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