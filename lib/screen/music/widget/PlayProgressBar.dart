import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import '../Services/PlayerManager.dart';

class PlayProgressBar extends StatelessWidget {
  const PlayProgressBar({
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