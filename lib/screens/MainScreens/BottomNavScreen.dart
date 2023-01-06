// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simfonie/Controllers/Get_all_song_controller.dart';
import 'package:simfonie/Text/text_all_widget.dart';
import 'package:simfonie/db/favourite_db.dart';
import 'package:simfonie/screens/MainScreens/SettingsScreens/SettingsScreen.dart';
import 'package:simfonie/screens/MainScreens/songListScreen.dart';
import 'package:simfonie/screens/MainScreens/exploreScreen.dart';
import 'package:simfonie/screens/MainScreens/searchSongsScreen.dart';
import 'package:simfonie/screens/MiniScreens/miniPlayer.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _currentSelectedIndex = 0;
  final pages = const [
    ListSongScreen(),
    SearchScreen(),
    ExploreScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: FavoriteDb.favoriteSongs,
            builder:
                (BuildContext context, List<SongModel> music, Widget? child) {
              return Stack(
                children: [
                  pages[_currentSelectedIndex],
                  Positioned(
                      bottom: 0,
                      child: Column(
                        children: [
                          if (GetAllSongController.audioPlayer.currentIndex !=
                              null)
                            Column(
                              children: [
                                MiniPlayer(),
                              ],
                            )
                          else
                            const SizedBox(),
                        ],
                      ))
                ],
              );
            }),
        bottomNavigationBar: Container(
          color: Color.fromARGB(255, 39, 0, 107),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            child: GNav(
                selectedIndex: _currentSelectedIndex,
                onTabChange: (newIndex) {
                  setState(() {
                    _currentSelectedIndex = newIndex;
                  });
                },
                tabBorderRadius: 20,
                padding: EdgeInsets.all(11),
                rippleColor: Colors.purpleAccent,
                tabActiveBorder:
                    Border.all(color: Colors.purpleAccent, width: 1),
                tabBackgroundColor: Color.fromARGB(255, 38, 12, 71),
                gap: 8,
                activeColor: Colors.purpleAccent,
                backgroundColor: Color.fromARGB(255, 39, 0, 107),
                tabs: [
                  GButton(
                    icon: Icons.toc,
                    text: TextAllWidget.gbuttonList,
                    iconColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.search,
                    text: TextAllWidget.gbuttonSearch,
                    iconColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.explore_outlined,
                    text: TextAllWidget.gbuttonExplore,
                    iconColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: TextAllWidget.gbuttonSettings,
                    iconColor: Colors.white,
                  )
                ]),
          ),
        ));
  }
}
