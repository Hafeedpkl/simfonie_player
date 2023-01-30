import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:simfonie/model/model/simfonie_model.dart';
import 'package:simfonie/view/music_playing/provider/song_model_provider.dart';
import 'package:simfonie/view/splash_screen/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(SimfonieModelAdapter().typeId)) {
    Hive.registerAdapter(SimfonieModelAdapter());
  }
  await Hive.initFlutter();
  await Hive.openBox<int>('FavoriteDB');
  await Hive.openBox('recentSongNotifier');
  await Hive.openBox<SimfonieModel>('playlistDb');
  await Hive.openBox('topBeatsNotifier');

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => SongModelProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      title: 'simfonie player',
      home: ScreenSplash(),
    );
  }
}
