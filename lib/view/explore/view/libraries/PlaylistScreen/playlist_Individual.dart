import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:simfonie/controllers/Get_all_song_controller.dart';
import 'package:simfonie/model/model/simfonie_model.dart';
import 'package:simfonie/view/explore/view/libraries/PlaylistScreen/playlist_add_song_screen.dart';

import '../../../../../controllers/get_recent_song_controller.dart';
import '../../../../music_playing/provider/song_model_provider.dart';
import '../../../../music_playing/NowPlayingScreen.dart';

class PlaylistSingle extends StatefulWidget {
  final SimfonieModel playlist;
  final int findex;

  const PlaylistSingle(
      {super.key, required this.playlist, required this.findex});

  @override
  State<PlaylistSingle> createState() => _PlaylistSingleState();
}

class _PlaylistSingleState extends State<PlaylistSingle> {
  @override
  Widget build(BuildContext context) {
    late List<SongModel> songPlaylist;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 5, 46),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset('assets/images/ellipse_favourite.png'),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      widget.playlist.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'poppins'),
                    ),
                    SizedBox(
                      width: 50,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: ValueListenableBuilder(
                            valueListenable:
                                Hive.box<SimfonieModel>('playlistDb')
                                    .listenable(),
                            builder: (BuildContext context,
                                Box<SimfonieModel> music, Widget? child) {
                              songPlaylist = listPlaylist(
                                  music.values.toList()[widget.findex].songId);
                              return songPlaylist.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'Add Some Songs',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'poppins'),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemBuilder: ((context, index) {
                                        // allSongs.addAll(items.data!);
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6, right: 6),
                                          child: Card(
                                            color: const Color.fromARGB(
                                                255, 18, 2, 61),
                                            shadowColor: Colors.purpleAccent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 132, 0, 255))),
                                            child: ListTile(
                                              iconColor: Colors.white,
                                              selectedColor:
                                                  Colors.purpleAccent,
                                              leading: QueryArtworkWidget(
                                                  id: songPlaylist[index].id,
                                                  type: ArtworkType.AUDIO,
                                                  nullArtworkWidget:
                                                      const CircleAvatar(
                                                          radius: 27,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/images/playlist.png'))),
                                              title: Text(
                                                songPlaylist[index].title,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: 'poppins',
                                                    color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                songPlaylist[index].artist!,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    fontFamily: 'poppins',
                                                    fontSize: 12,
                                                    color: Colors.blueGrey),
                                              ),
                                              trailing: IconButton(
                                                onPressed: () {
                                                  widget.playlist.deleteData(
                                                      songPlaylist[index].id);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onTap: () {
                                                List<SongModel> newMusicList = [
                                                  ...songPlaylist
                                                ];
                                                GetAllSongController.audioPlayer
                                                    .stop();
                                                GetAllSongController.audioPlayer
                                                    .setAudioSource(
                                                        GetAllSongController
                                                            .createSongList(
                                                                newMusicList),
                                                        initialIndex: index);
                                                GetRecentSongController
                                                    .addRecentlyPlayed(
                                                        newMusicList[index].id);

                                                context
                                                    .read<SongModelProvider>()
                                                    .setId(
                                                        newMusicList[index].id);
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return PlayScreen(
                                                    songModelList: songPlaylist,
                                                    count: songPlaylist.length,
                                                  );
                                                }));
                                              },
                                            ),
                                          ),
                                        );
                                      }),
                                      itemCount: songPlaylist.length,
                                    );
                            })),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return SongListAddPage(
                  playlist: widget.playlist,
                );
              },
            ));
          },
          label: const Text('Add Songs')),
    );
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < GetAllSongController.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetAllSongController.songscopy[i].id == data[j]) {
          plsongs.add(GetAllSongController.songscopy[i]);
        }
      }
    }
    return plsongs;
  }
}
