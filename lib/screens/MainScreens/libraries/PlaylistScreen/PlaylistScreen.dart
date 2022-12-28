import 'package:flutter/material.dart';
import 'package:simfonie/screens/MainScreens/libraries/PlaylistScreen/playlist%20Individual.dart';

import '../FavouriteSongsScreen/favourites.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 5, 46),
      body: SafeArea(
        child: Column(children: [
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
                'Playlists',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'poppins'),
              ),
              IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                  PopupMenuButton(
                    child: Center(child: Text('click here')),
                    itemBuilder: (context) {
                      return List.generate(5, (index) {
                        return PopupMenuItem(
                          child: Text('button no $index'),
                        );
                      });
                    },
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          Container(
            width: 365,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouriteScreen(),
                    ));
              },
              child: Card(
                color: const Color.fromARGB(255, 18, 2, 61),
                shadowColor: Colors.purpleAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 132, 0, 255))),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/PlaylistScreen/playlist-small-favourite.png',
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Center(
                        child: Text(
                          'Favourites',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'poppins'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  // height: 400,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      // allSongs.addAll(items.data!);
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 6, bottom: 8),
                        child: Card(
                          color: const Color.fromARGB(255, 18, 2, 61),
                          shadowColor: Colors.purpleAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 132, 0, 255))),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/PlaylistScreen/playlist-small-playlistscreen.png',
                                fit: BoxFit.fill,
                                width: double.infinity,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlaylistSingle(
                                            playListName:
                                                'Playlist ${index + 1}'),
                                      ));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 40),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          'Playlist ${index + 1}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              fontFamily: 'poppins'),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    itemCount: 2,
                  )),
            ),
          )
        ]),
      ),
    );
  }
}
