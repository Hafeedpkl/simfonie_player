import 'package:flutter/material.dart';
import 'package:simfonie/screens/MINI%20SCREENS/Playlist%20Screen/PlaylistScreen.dart';
import 'package:simfonie/screens/MINI%20SCREENS/Top%20Beats/TopBeats.dart';
import 'package:simfonie/screens/mini%20screens/FavouriteSongsScreen/favourites.dart';

import '../../MINI SCREENS/widgets/DrawerWidget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawerwidget(),
        appBar: AppBar(
          title: Center(
            child: Image.asset(
              'assets/images/simfonie_image.png',
              scale: 1.3,
              // height: 50,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 20, 5, 46),
          actions: const [
            SizedBox(
              width: 30,
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 20, 5, 46),
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              height: 210,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FavouriteScreen(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 158,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent),
                            child: Image.asset(
                              'assets/images/Favourite-paylist.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Favourites',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'poppins'),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaylistScreen(),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black),
                            child: Image.asset(
                              'assets/images/playlists-small.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'playlists',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'poppins'),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      child: Column(
                        children: [
                          Container(
                            height: 156,
                            width: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.transparent),
                            child: Image.asset(
                              'assets/images/top-music.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Top Beats',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'poppins'),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TopBeatsScreen(),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "   Recent songs",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 15,
              ),
            ),
            Expanded(
              child: SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      // allSongs.addAll(items.data!);
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
                            leading: const CircleAvatar(
                                radius: 27,
                                backgroundImage:
                                    AssetImage('assets/images/playlist.png')),
                            title: Text(
                              'Song $index',
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: 'poppins',
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                              'artist $index',
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 12,
                                  color: Colors.blueGrey),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.favorite_outline),
                              onPressed: () {},
                            ),
                            onTap: () {},
                          ),
                        ),
                      );
                    }),
                    itemCount: 10,
                  )),
            )
          ]),
        ));
  }
}
