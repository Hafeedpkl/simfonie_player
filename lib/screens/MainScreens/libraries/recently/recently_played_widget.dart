import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simfonie/Controllers/get_recent_song_controller.dart';
import 'package:simfonie/db/favourite_db.dart';

import '../../../../Controllers/Get_all_song_controller.dart';
import '../../../MiniScreens/MenuButtonWidget/MenuButton.dart';
import '../../../MiniScreens/NowPlayingScreen/NowPlayingScreen.dart';

class RecentlyPlayedWidget extends StatefulWidget {
  const RecentlyPlayedWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentlyPlayedWidget> createState() => _RecentlyPlayedWidgetState();
}

class _RecentlyPlayedWidgetState extends State<RecentlyPlayedWidget> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  static List<SongModel> recentSong = [];

  @override
  void initState() {
    super.initState();
    init();
    setState(() {});
  }

  Future init() async {
    await GetRecentSongController.getRecentSongs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FavoriteDb.favoriteSongs;
    return FutureBuilder(
      future: GetRecentSongController.getRecentSongs(),
      builder: (context, items) {
        return ValueListenableBuilder(
          valueListenable: GetRecentSongController.recentSongNotifier,
          builder:
              (BuildContext context, List<SongModel> value, Widget? child) {
            if (value.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    'No Song In Recents',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              );
            } else {
              final temp = value.reversed.toList();
              recentSong = temp.toSet().toList();
              return FutureBuilder<List<SongModel>>(
                future: _audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, items) {
                  if (items.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (items.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Song Available',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return ListView.builder(
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
                                id: recentSong[index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const CircleAvatar(
                                    radius: 27,
                                    backgroundImage: AssetImage(
                                        'assets/images/playlist.png'))),
                            title: Text(
                              recentSong[index].displayNameWOExt,
                              maxLines: 1,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: 'poppins',
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                              '${recentSong[index].artist == "<unknown>" ? "Unknown Artist" : recentSong[index].artist}',
                              maxLines: 1,
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 12,
                                  color: Colors.blueGrey),
                            ),
                            trailing: FavoriteMenuButton(
                                songFavorite: recentSong[index]),
                            onTap: () {
                              GetAllSongController.audioPlayer.setAudioSource(
                                  GetAllSongController.createSongList(
                                      recentSong),
                                  initialIndex: index);
                              GetAllSongController.audioPlayer.play();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return PlayScreen(
                                  songModelList:
                                      GetAllSongController.playingSong,
                                );
                              }));
                            },
                          ),
                        ),
                      );
                    }),
                    itemCount: recentSong.length,
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
