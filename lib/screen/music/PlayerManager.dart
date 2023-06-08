import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../model/Music.dart';

class PlayerManager {
  final List<Music> musicList;
  final progressNotifier = ValueNotifier<ProgressBarState>(ProgressBarState(current: Duration.zero, buffered: Duration.zero, total: Duration.zero,),);
  final playingButtonNotifier = ValueNotifier<PlayingButtonState>(PlayingButtonState.playing);
  final currentMusicNotifier = ValueNotifier<CurrentMusicState>(CurrentMusicState(music: Music(id: '', title: '', url: '', creator: '', thumbnail: '', creatorUrl: '', license: '', licenseVersion: '', licenseUrl: '',)));
  final loopModeButtonNotifier = ValueNotifier<LoopMode>(LoopMode.off);
  final shuffleButtonNotifier = ValueNotifier<bool>(false);
  final speedNotifier = ValueNotifier<double>(1.0);
  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playList;

  PlayerManager({required this.musicList}){
    _playList = _createPlayList();
    _audioPlayer = AudioPlayer();
  }

  ConcatenatingAudioSource _createPlayList() {
    return ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: musicList.map((music) => AudioSource.uri(Uri.parse(music.url))).toList(),
    );
  }

  void init(int initialIndex){
    _audioPlayer.setAudioSource(_playList,initialIndex: initialIndex,initialPosition: Duration.zero);
    _audioPlayer.play();
    _setPlayerStateListener();
    _setPositionStreamListener();
    _setBufferedListener();
    _setDurationListener();
    _setCurrentIndexListener();
    _setLoopModeListener();
    _setShuffleModeEnableListener();
    _setSpeedListener();
  }

  void _setPlayerStateListener(){
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playingButtonNotifier.value = PlayingButtonState.loading;
      } else if (!isPlaying) {
        playingButtonNotifier.value = PlayingButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playingButtonNotifier.value = PlayingButtonState.playing ;
      } else {
        _audioPlayer.seek(Duration.zero) ;
        _audioPlayer.pause();
      }
    });
  }

  void _setPositionStreamListener(){
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _setBufferedListener(){
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _setDurationListener(){
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void _setCurrentIndexListener(){
    _audioPlayer.currentIndexStream.listen((index) {
      currentMusicNotifier.value = CurrentMusicState(music: musicList[index!]);
    });
  }

  void _setLoopModeListener() {
    _audioPlayer.loopModeStream.listen((loopMode) {
      loopModeButtonNotifier.value = loopMode;
    });
  }

  void _setShuffleModeEnableListener() {
    _audioPlayer.shuffleModeEnabledStream.listen((shuffleMode) {
      shuffleButtonNotifier.value = shuffleMode;
    });
  }

  void _setSpeedListener() {
    _audioPlayer.speedStream.listen((speed) {
      speedNotifier.value = speed;
    });
  }

  Music getCurrentMusic(){
    return musicList[_audioPlayer.currentIndex??0];
  }

  void seekToNext() async{
    await _audioPlayer.seekToNext();

  }

  void seekToPrevious() async{
    await _audioPlayer.seekToPrevious();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void play() {
    _audioPlayer.play();
  }
  void pause() {
    _audioPlayer.pause();
  }
  void dispose() {
    _audioPlayer.dispose();
  }

  void setVolume(double volume){
    _audioPlayer.setVolume(volume);
  }

  void setLoopMode(LoopMode loopMode){
    _audioPlayer.setLoopMode(loopMode);
  }

  void setShuffleModeEnabled(bool enabled){
    _audioPlayer.setShuffleModeEnabled(enabled);
  }

  void setSpeed(double speed){
    _audioPlayer.setSpeed(speed);
  }

}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum PlayingButtonState {
  paused, playing, loading
}

class CurrentMusicState{
  final Music music;
  CurrentMusicState({required this.music});
}