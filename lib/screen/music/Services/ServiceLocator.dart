import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async{
  getIt.registerSingleton<AudioPlayer>(AudioPlayer());
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.wilky.openmusic.open_music.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
}
