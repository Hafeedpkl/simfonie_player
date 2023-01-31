import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controllers/Get_all_song_controller.dart';

class HomeController extends GetxController {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  // bool isFavourite = false;
  bool sizedBoxSpacing = false;
  List<SongModel> allSongs = [];

  @override
  void sizedboxchecking() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        sizedBoxSpacing = true;
      }
    });

    update();
  }

  Future<void> reqeustStoragePermission() async {
    // if (!kIsWeb) {
    //   bool PermissionStatus = await _audioQuery.permissionsRequest();
    //   if (!PermissionStatus) {
    //     await _audioQuery.permissionsRequest();
    //   }
    // }
    Permission.storage.request();
    update();
  }
}
