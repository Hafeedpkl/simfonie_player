import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simfonie/Controllers/Get_Top_Beats_controller.dart';
import 'package:simfonie/Controllers/Get_all_song_controller.dart';
import 'package:simfonie/screens/MiniScreens/MenuButtonWidget/MenuButton.dart';
import 'package:simfonie/screens/MiniScreens/NowPlayingScreen/NowPlayingScreen.dart';

class TopBeatsScreen extends StatefulWidget {
  const TopBeatsScreen({super.key});

  @override
  State<TopBeatsScreen> createState() => _TopBeatsScreenState();
}

class _TopBeatsScreenState extends State<TopBeatsScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var filteredList;

    int duplicateCounter = 0;
    List<SongModel> topBeatsList = [];
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
                          log('hi');
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const Text(
                        'Top Beats',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'poppins'),
                      ),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: GetTopBeatsController.getTopBeatSongs(),
                      builder: (context, items) {
                        return ValueListenableBuilder(
                            valueListenable:
                                GetTopBeatsController.topBeatsNotifier,
                            builder: (BuildContext context,
                                List<SongModel> value, Widget? child) {
                              if (value.isEmpty) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Lottie.asset(
                                          'assets/lottie/73060-blue-search-not-found.json'),
                                      const Text(
                                        'No Songs found',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                );
                              }

                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height: 400,
                                      width: double.infinity,
                                      child: FutureBuilder<List<SongModel>>(
                                          future: _audioQuery.querySongs(
                                            sortType: null,
                                            orderType: OrderType.ASC_OR_SMALLER,
                                            uriType: UriType.EXTERNAL,
                                            ignoreCase: true,
                                          ),
                                          builder: (context, item) {
                                            if (item.data == null) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }

                                            if (item.data!.isEmpty) {
                                              return const Center(
                                                  child: Text(
                                                'No Songs Available',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ));
                                            }

                                            for (var i = 0;
                                                i < value.length;
                                                i++) {
                                              duplicateCounter = 0;
                                              for (var j = i + 1;
                                                  j < value.length;
                                                  j++) {
                                                if (value[i] == value[j]) {
                                                  duplicateCounter++;
                                                }
                                                if (duplicateCounter > 5) {
                                                  filteredList =
                                                      value.toSet().toList();
                                                }
                                              }
                                            }

                                            if (filteredList != null) {
                                              topBeatsList = filteredList;
                                            }
                                            return ListView.builder(
                                              itemBuilder: ((context, index) {
                                                // allSongs.addAll(items.data!);
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6, right: 6),
                                                  child: Card(
                                                    color: const Color.fromARGB(
                                                        255, 18, 2, 61),
                                                    shadowColor:
                                                        Colors.purpleAccent,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        side: const BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    132,
                                                                    0,
                                                                    255))),
                                                    child: ListTile(
                                                      iconColor: Colors.white,
                                                      selectedColor:
                                                          Colors.purpleAccent,
                                                      leading: QueryArtworkWidget(
                                                          id: topBeatsList[
                                                                  index]
                                                              .id,
                                                          type:
                                                              ArtworkType.AUDIO,
                                                          nullArtworkWidget:
                                                              const CircleAvatar(
                                                                  radius: 27,
                                                                  backgroundImage:
                                                                      AssetImage(
                                                                          'assets/images/playlist.png'))),
                                                      title: Text(
                                                        topBeatsList[index]
                                                            .displayNameWOExt,
                                                        style: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontFamily:
                                                                'poppins',
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      subtitle: Text(
                                                        topBeatsList[index]
                                                                    .artist ==
                                                                "<unknown>"
                                                            ? "Unknown Artist"
                                                            : topBeatsList[
                                                                    index]
                                                                .artist
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'poppins',
                                                            fontSize: 12,
                                                            color: Colors
                                                                .blueGrey),
                                                      ),
                                                      trailing:
                                                          FavoriteMenuButton(
                                                        songFavorite:
                                                            topBeatsList[index],
                                                      ),
                                                      onTap: () {
                                                        GetAllSongController
                                                            .audioPlayer
                                                            .setAudioSource(
                                                                GetAllSongController
                                                                    .createSongList(
                                                                        topBeatsList),
                                                                initialIndex:
                                                                    index);
                                                        GetAllSongController
                                                            .audioPlayer
                                                            .play();
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => PlayScreen(
                                                                  songModelList:
                                                                      GetAllSongController
                                                                          .playingSong),
                                                            ));
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }),
                                              itemCount: topBeatsList.length,
                                            );
                                          })),
                                ),
                              );
                            });
                      })
                ],
              ),
            ],
          ),
        ));
  }
}
