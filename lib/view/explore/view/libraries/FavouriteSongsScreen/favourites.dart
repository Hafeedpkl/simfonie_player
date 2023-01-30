import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simfonie/controllers/Get_all_song_controller.dart';
import 'package:simfonie/model/functions/favourite_db.dart';
import '../../../../music_playing/NowPlayingScreen.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: FavoriteDb.favoriteSongs,
        builder:
            (BuildContext ctx, List<SongModel> favoriteData, Widget? child) {
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
                            const Text(
                              'Favourite songs',
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
                          child: ValueListenableBuilder(
                              valueListenable: FavoriteDb.favoriteSongs,
                              builder: (BuildContext ctx,
                                  List<SongModel> favoriteData, Widget? child) {
                                if (favoriteData.isEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 70, left: 10),
                                    child: Text(
                                      'No Favorite Songs',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        height: 400,
                                        width: double.infinity,
                                        child: ListView.builder(
                                          itemBuilder: ((context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6, right: 6),
                                              child: Card(
                                                color: const Color.fromARGB(
                                                    255, 18, 2, 61),
                                                shadowColor:
                                                    Colors.purpleAccent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: const BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 132, 0, 255))),
                                                child: ListTile(
                                                  iconColor: Colors.white,
                                                  selectedColor:
                                                      Colors.purpleAccent,
                                                  leading: QueryArtworkWidget(
                                                      id: favoriteData[index]
                                                          .id,
                                                      type: ArtworkType.AUDIO,
                                                      nullArtworkWidget:
                                                          const CircleAvatar(
                                                              radius: 27,
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      'assets/images/playlist.png'))),
                                                  title: Text(
                                                    favoriteData[index]
                                                        .displayNameWOExt,
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'poppins',
                                                        color: Colors.white),
                                                  ),
                                                  subtitle: Text(
                                                    favoriteData[index]
                                                        .artist
                                                        .toString(),
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: 'poppins',
                                                        fontSize: 12,
                                                        color: Colors.blueGrey),
                                                  ),
                                                  trailing: IconButton(
                                                    icon: Icon(
                                                        Icons.heart_broken),
                                                    onPressed: () {
                                                      FavoriteDb.favoriteSongs
                                                          .notifyListeners();
                                                      FavoriteDb.delete(
                                                          favoriteData[index]
                                                              .id);
                                                      const snackbar = SnackBar(
                                                        content: Text(
                                                          'Song Deleted From your Favourites',
                                                        ),
                                                        duration: Duration(
                                                            seconds: 1),
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255, 20, 5, 46),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackbar);
                                                    },
                                                  ),
                                                  onTap: () {
                                                    List<SongModel>
                                                        favoriteList = [
                                                      ...favoriteData
                                                    ];
                                                    GetAllSongController
                                                        .audioPlayer
                                                        .stop();
                                                    GetAllSongController
                                                        .audioPlayer
                                                        .setAudioSource(
                                                            GetAllSongController
                                                                .createSongList(
                                                                    favoriteList),
                                                            initialIndex:
                                                                index);
                                                    GetAllSongController
                                                        .audioPlayer
                                                        .play();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PlayScreen(
                                                                  songModelList:
                                                                      favoriteList),
                                                        ));
                                                  },
                                                ),
                                              ),
                                            );
                                          }),
                                          itemCount: favoriteData.length,
                                        )),
                                  );
                                }
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
