// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:simfonie/screens/MainScreens/SettingsScreen/SettingsScreen.dart';
import 'package:simfonie/screens/MainScreens/SongListScreen/songListScreen.dart';
import 'package:simfonie/screens/MainScreens/ExploreScreen/exploreScreen.dart';
import 'package:simfonie/screens/MainScreens/SearchScreen/searchSongsScreen.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _currentSelectedIndex = 0;
  final pages = const [
    ListSongScreen(),
    // TopBeatsScreen(),
    SearchScreen(),
    ExploreScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_currentSelectedIndex],
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
                tabs: const [
                  GButton(
                    icon: Icons.toc,
                    text: 'list',
                    iconColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'search',
                    iconColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.explore_outlined,
                    text: 'explore',
                    iconColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'settings',
                    iconColor: Colors.white,
                  )
                ]),
          ),
        )
     
        );
  }
}
