import 'package:flutter/material.dart';
import '../../MainScreens/SettingsScreens/AboutScreen.dart';
import '../../MainScreens/SettingsScreens/SettingsScreen.dart';
import '../../MainScreens/libraries/FavouriteSongsScreen/favourites.dart';
import '../../MainScreens/libraries/PlaylistScreen/PlaylistScreen.dart';
import '../../MainScreens/libraries/Top Beats/TopBeats.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 180,
      backgroundColor: Color.fromARGB(255, 20, 5, 46),
      child: ListView(
        children: [
          DrawerList(
            icon: Icons.home,
            name: 'Home',
          ),
          DrawerList(
            name: 'Playlists',
            icon: Icons.playlist_play,
            ontapped: PlaylistScreen(),
          ),
          DrawerList(
            name: 'Favourites',
            icon: Icons.favorite,
            ontapped: FavouriteScreen(),
          ),
          DrawerList(
            name: 'Top Beats',
            icon: Icons.my_library_music_outlined,
            ontapped: TopBeatsScreen(),
          ),
          DrawerList(
            name: 'Settings',
            icon: Icons.settings,
            ontapped: SettingsScreen(),
          ),
          DrawerList(
            name: 'About',
            icon: Icons.info_outline,
            ontapped: AboutScreen(),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DrawerList extends StatelessWidget {
  String name;
  IconData icon;
  Widget? ontapped;
  DrawerList({Key? key, required this.name, required this.icon, this.ontapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (ontapped == null) {
          Navigator.pop(context);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ontapped!,
              ));
        }
      },
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        name,
        style: const TextStyle(fontFamily: 'poppins', color: Colors.white),
      ),
    );
  }
}
