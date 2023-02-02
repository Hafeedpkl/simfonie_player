import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchController extends GetxController {
  late List<SongModel> allsongs;
  List<SongModel> foundSongs = [];
  final audioQuery = OnAudioQuery();

  void songsLoading() async {
    allsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    update();
    foundSongs = allsongs;
    update();
  }

  void updateList(String enteredText) {
    List<SongModel> results = [];
    if (enteredText.isEmpty) {
      results = allsongs;
    } else {
      results = allsongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .contains(enteredText.toLowerCase().trim()))
          .toList();
    }

    foundSongs = results;
    update();
  }
}
