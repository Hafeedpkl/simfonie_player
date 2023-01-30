// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simfonie/controllers/Get_all_song_controller.dart';
import 'package:simfonie/view/bottom_navigation/controller/bottom_nav_controller.dart';
import 'package:simfonie/view/widgets/Text/text_all_widget.dart';
import 'package:simfonie/model/functions/favourite_db.dart';
import 'package:simfonie/view/settings/SettingsScreen.dart';
import 'package:simfonie/view/home/songListScreen.dart';
import 'package:simfonie/view/explore/view/exploreScreen.dart';
import 'package:simfonie/view/search/searchSongsScreen.dart';
import 'package:simfonie/view/widgets/miniplayer/miniPlayer.dart';

class ScreenHome extends StatelessWidget {
  BottomNavController bottomNavController = Get.put(BottomNavController());
  ScreenHome({super.key});

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
        body: GetBuilder<BottomNavController>(builder: (context) {
          return ValueListenableBuilder(
              valueListenable: FavoriteDb.favoriteSongs,
              builder:
                  (BuildContext context, List<SongModel> music, Widget? child) {
                return Stack(
                  children: [
                    pages[bottomNavController.currentIndex],
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
              });
        }),
        bottomNavigationBar: Container(
          color: Color.fromARGB(255, 39, 0, 107),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            child: GNav(
                selectedIndex: _currentSelectedIndex,
                onTabChange: (newIndex) {
                  _currentSelectedIndex = newIndex;
                  bottomNavController.currentIndex = newIndex;
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
