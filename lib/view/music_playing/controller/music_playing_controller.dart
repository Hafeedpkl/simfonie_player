import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../controllers/Get_all_song_controller.dart';

class MusicPlayingController extends GetxController {
  Duration duration = const Duration();
  Duration position = const Duration();
  bool firstsong = false;
  bool lastSong = false;
  int large = 0;
  bool isShuffling = false;
  List<AudioSource> songList = [];
  int currentIndex = 0;
  List<int> topBeatSongList = [];
  int counter = 0;

  @override
  void onInit() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        currentIndex = index;
        update();
        GetAllSongController.currentIndexes = index;
      }
    });
    super.onInit();
    playSong();
    update();
  }

  String formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
  }

  void playSong() {
    GetAllSongController.audioPlayer.play();
    GetAllSongController.audioPlayer.durationStream.listen((d) {
      duration = d!;
      update();
    });
    GetAllSongController.audioPlayer.positionStream.listen((p) {
      position = p;
      update();
    });
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
  }
}
