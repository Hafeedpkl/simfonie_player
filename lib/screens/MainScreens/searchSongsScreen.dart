import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../Controllers/Get_all_song_controller.dart';
import '../../provider/song_model_provider.dart';
import 'libraries/FavouriteSongsScreen/favoriteButton.dart';
import '../MiniScreens/NowPlayingScreen/NowPlayingScreen.dart';
import 'songListScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

List<SongModel> allsongs = [];
List<SongModel> foundSongs = [];
final audioPlayer = AudioPlayer();
final audioQuery = OnAudioQuery();

@override
class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    songsLoading();
  }

  void updateList(String enteredText) {
    List<SongModel> results = [];
    if (enteredText.isEmpty) {
      results = allsongs;
    } else {
      results = allsongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .contains(enteredText.toLowerCase()))
          .toList();
    }
    setState(() {
      foundSongs = results;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 20, 5, 46),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) => updateList(value),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xff302360),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                        hintText: 'Search Song',
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        prefixIconColor: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '   Results',
                  style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
                ),
                foundSongs.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: Card(
                              color: const Color.fromARGB(255, 18, 2, 61),
                              shadowColor: Colors.purpleAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: Color.fromARGB(255, 132, 0, 255))),
                              child: ListTile(
                                iconColor: Colors.white,
                                selectedColor: Colors.purpleAccent,
                                leading: QueryArtworkWidget(
                                    id: foundSongs[index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: const CircleAvatar(
                                        radius: 27,
                                        backgroundImage: AssetImage(
                                            'assets/images/playlist.png'))),
                                title: Text(
                                  foundSongs[index].displayNameWOExt,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: 'poppins',
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  foundSongs[index].artist.toString() ==
                                          "<unknown>"
                                      ? "Unknown Artist"
                                      : foundSongs[index].artist.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 12,
                                      color: Colors.blueGrey),
                                ),
                                trailing: FavoriteButton(
                                  songFavorite: startSong[index],
                                ),
                                onTap: () {
                                  GetAllSongController.audioPlayer
                                      .setAudioSource(
                                          GetAllSongController.createSongList(
                                              foundSongs),
                                          initialIndex: index);
                                  GetAllSongController.audioPlayer.play();
                                  context
                                      .read<SongModelProvider>()
                                      .setId(foundSongs[index].id);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PlayScreen(
                                      songModelList: foundSongs,
                                    );
                                  }));
                                },
                              ),
                            ),
                          );
                        }),
                        itemCount: foundSongs.length,
                      ))
                    : Center(
                        child: Lottie.asset(
                            'assets/lottie/68796-empty-search.json'),
                      )
              ],
            )),
          ),
        ));
  }

  void songsLoading() async {
    allsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    foundSongs = allsongs;
  }
}
