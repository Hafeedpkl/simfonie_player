// ignore_for_file: sized_box_for_whitespace, file_names
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simfonie/Controllers/Get_all_song_controller.dart';
import 'package:simfonie/db/favourite_db.dart';
import 'package:simfonie/screens/MINI%20SCREENS/FavouriteSongsScreen/favouriteMenuButton.dart';
import 'package:simfonie/screens/MINI%20SCREENS/FavouriteSongsScreen/favourites.dart';
import 'package:simfonie/screens/MINI%20SCREENS/Playlist%20Screen/PlaylistScreen.dart';
import 'package:simfonie/screens/mini%20screens/NowPlayingScreen/NowPlayingScreen.dart';

import '../../../provider/song_model_provider.dart';
import '../../MINI SCREENS/FavouriteSongsScreen/favoriteButton.dart';
import '../../MINI SCREENS/widgets/DrawerWidget.dart';

class ListSongScreen extends StatefulWidget {
  const ListSongScreen({super.key});

  @override
  State<ListSongScreen> createState() => _ListSongScreenState();
}

List<SongModel> startSong = [];

class _ListSongScreenState extends State<ListSongScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isFavourite = false;
  List<SongModel> allSongs = [];

  void playSong(String? uri) {
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } on Exception {
      log('Error parsing Song');
    }
  }

  @override
  void initState() {
    super.initState();
    reqeustStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawerwidget(),
        appBar: AppBar(
          title: Center(
            child: Image.asset(
              'assets/images/simfonie_image.png',
              scale: 1.3,
              // height: 50,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 20, 5, 46),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistScreen(),
                    ));
              },
              icon: const Icon(
                Icons.playlist_play,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 20, 5, 46),
        body: SafeArea(
          child: Stack(children: [
            Row(
              children: [
                Image.asset('assets/images/ellipse_blue_main.png'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      // color: Colors.white,
                      height: 550,
                      width: double.infinity,
                      child: FutureBuilder<List<SongModel>>(
                          future: _audioQuery.querySongs(
                              sortType: null,
                              orderType: OrderType.ASC_OR_SMALLER,
                              uriType: UriType.EXTERNAL),
                          builder: ((context, items) {
                            if (items.data == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (items.data!.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No Songs found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }
                            startSong = items.data!;
                            if (!FavoriteDb.isInitialized) {
                              FavoriteDb.initialize(items.data!);
                            }

                            return ListView.builder(
                              itemBuilder: ((context, index) {
                                allSongs.addAll(items.data!);
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 6, right: 6),
                                  child: Card(
                                    color: const Color.fromARGB(255, 18, 2, 61),
                                    shadowColor: Colors.purpleAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 132, 0, 255))),
                                    child: ListTile(
                                      iconColor: Colors.white,
                                      selectedColor: Colors.purpleAccent,
                                      leading: QueryArtworkWidget(
                                          id: items.data![index].id,
                                          type: ArtworkType.AUDIO,
                                          nullArtworkWidget: const CircleAvatar(
                                              radius: 27,
                                              backgroundImage: AssetImage(
                                                  'assets/images/playlist.png'))),
                                      title: Text(
                                        items.data![index].displayNameWOExt,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontFamily: 'poppins',
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        items.data![index].artist.toString() ==
                                                "<unknown>"
                                            ? "Unknown Artist"
                                            : items.data![index].artist
                                                .toString(),
                                        style: const TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: 12,
                                            color: Colors.blueGrey),
                                      ),
                                      trailing: FavoriteMenuButton(
                                          songFavorite: startSong[index]),
                                      onTap: () {
                                        GetAllSongController.audioPlayer
                                            .setAudioSource(
                                                GetAllSongController
                                                    .createSongList(
                                                        items.data!),
                                                initialIndex: index);
                                        // GetAllSongController.audioPlayer.play();
                                        context
                                            .read<SongModelProvider>()
                                            .setId(items.data![index].id);
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return PlayScreen(
                                            songModelList: items.data!,
                                          );
                                        }));
                                      },
                                    ),
                                  ),
                                );
                              }),
                              itemCount: items.data!.length,
                            );
                          }))),
                ),
              ],
            ),
          ]),
        ));
  }

  Future<void> reqeustStoragePermission() async {
    // if (!kIsWeb) {
    //   bool PermissionStatus = await _audioQuery.permissionsRequest();
    //   if (!PermissionStatus) {
    //     await _audioQuery.permissionsRequest();
    //   }
    // }
    Permission.storage.request();
  }
}
