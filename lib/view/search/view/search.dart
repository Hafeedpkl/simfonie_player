import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:simfonie/view/search/controller/search_controller.dart';
import 'package:simfonie/view/widgets/menu_button/MenuButton.dart';
import '../../../controllers/Get_all_song_controller.dart';
import '../../music_playing/provider/song_model_provider.dart';
import '../../music_playing/view/music_playing.dart';
import '../../home/view/songListScreen.dart';

class SearchScreen extends StatelessWidget {
  SearchController searchController = Get.put(SearchController());
  SearchScreen({super.key});
  TextEditingController searchEditingController = TextEditingController();

  Widget build(BuildContext context) {
    searchController.songsLoading();
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 20, 5, 46),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Center(child: GetBuilder<SearchController>(builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchEditingController,
                      onChanged: (value) {
                        searchController.updateList(value);
                      },
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
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'poppins'),
                  ),
                  searchController.foundSongs.isNotEmpty
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
                                        color:
                                            Color.fromARGB(255, 132, 0, 255))),
                                child: ListTile(
                                  iconColor: Colors.white,
                                  selectedColor: Colors.purpleAccent,
                                  leading: QueryArtworkWidget(
                                      id: searchController.foundSongs[index].id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: const CircleAvatar(
                                          radius: 27,
                                          backgroundImage: AssetImage(
                                              'assets/images/playlist.png'))),
                                  title: Text(
                                    searchController
                                        .foundSongs[index].displayNameWOExt,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: 'poppins',
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    searchController.foundSongs[index].artist
                                                .toString() ==
                                            "<unknown>"
                                        ? "Unknown Artist"
                                        : searchController
                                            .foundSongs[index].artist
                                            .toString(),
                                    style: const TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 12,
                                        color: Colors.blueGrey),
                                  ),
                                  trailing: FavoriteMenuButton(
                                    songFavorite: startSong[index],
                                  ),
                                  onTap: () {
                                    GetAllSongController.audioPlayer
                                        .setAudioSource(
                                            GetAllSongController.createSongList(
                                                searchController.foundSongs),
                                            initialIndex: index);
                                    GetAllSongController.audioPlayer.play();
                                    context.read<SongModelProvider>().setId(
                                        searchController.foundSongs[index].id);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return PlayScreen(
                                        songModelList:
                                            searchController.foundSongs,
                                      );
                                    }));
                                  },
                                ),
                              ),
                            );
                          }),
                          itemCount: searchController.foundSongs.length,
                        ))
                      : Center(
                          child: Lottie.asset(
                              'assets/lottie/68796-empty-search.json'),
                        )
                ],
              );
            })),
          ),
        ));
  }
}
