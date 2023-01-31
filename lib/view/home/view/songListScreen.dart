// ignore_for_file: sized_box_for_whitespace, file_names
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:simfonie/controllers/Get_Top_Beats_controller.dart';
import 'package:simfonie/controllers/Get_all_song_controller.dart';
import 'package:simfonie/controllers/get_recent_song_controller.dart';
import 'package:simfonie/model/functions/favourite_db.dart';
import 'package:simfonie/view/home/controller/home_controller.dart';

import '../../music_playing/provider/song_model_provider.dart';
import '../../widgets/menu_button/MenuButton.dart';
import '../../music_playing/view/music_playing.dart';
import '../../explore/view/libraries/PlaylistScreen/PlaylistScreen.dart';
import '../../widgets/Drawer/DrawerWidget.dart';

class ListSongScreen extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  ListSongScreen({super.key});

  final OnAudioQuery _audioQuery = OnAudioQuery();

  final AudioPlayer _audioPlayer = AudioPlayer();

  // bool isFavourite = false;
  bool sizedBoxSpacing = false;

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
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.reqeustStoragePermission();
    });
    homeController.sizedBoxSpacing;
    int count = 0;
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
          drawer: const DrawerWidget(),
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
                              GetAllSongController.songscopy =
                                  items.data!; //for playlist

                              return ListView.builder(
                                itemBuilder: ((context, index) {
                                  allSongs.addAll(items.data!);
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 6),
                                    child: Card(
                                      color:
                                          const Color.fromARGB(255, 18, 2, 61),
                                      shadowColor: Colors.purpleAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          items.data![index].artist
                                                      .toString() ==
                                                  "<unknown>"
                                              ? "Unknown Artist"
                                              : items.data![index].artist
                                                  .toString(),
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontFamily: 'poppins',
                                              fontSize: 12,
                                              color: Colors.blueGrey),
                                        ),
                                        trailing: FavoriteMenuButton(
                                            songFavorite: startSong[index],
                                            findex: index),
                                        onTap: () {
                                          GetAllSongController.audioPlayer
                                              .setAudioSource(
                                                  GetAllSongController
                                                      .createSongList(
                                                          items.data!),
                                                  initialIndex: index);
                                          GetRecentSongController
                                              .addRecentlyPlayed(
                                                  items.data![index].id);

                                          GetTopBeatsController.addTopBeats(
                                              items.data![index].id);

                                          context
                                              .read<SongModelProvider>()
                                              .setId(items.data![index].id);
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return PlayScreen(
                                              songModelList: items.data!,
                                              count: items.data!.length,
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
                  sizedBoxSpacing
                      ? const SizedBox(
                          height: 70,
                        )
                      : const SizedBox()
                ],
              ),
            ]),
          ));
    });
  }
}

List<SongModel> startSong = [];
