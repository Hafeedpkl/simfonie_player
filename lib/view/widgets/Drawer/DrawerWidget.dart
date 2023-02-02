import 'package:flutter/material.dart';
import 'package:simfonie/view/widgets/Text/text_all_widget.dart';
import '../../settings/AboutScreen.dart';
import '../../settings/SettingsScreen.dart';
import '../../explore/libraries/FavouriteSongsScreen/favourites.dart';
import '../../explore/libraries/PlaylistScreen/PlaylistScreen.dart';
import '../../explore/libraries/Top Beats/TopBeats.dart';

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
            name: TextAllWidget.drawerHome,
          ),
          DrawerList(
            name: TextAllWidget.drawerPlaylist,
            icon: Icons.playlist_play,
            ontapped: PlaylistScreen(),
          ),
          DrawerList(
            name: TextAllWidget.drawerFavorites,
            icon: Icons.favorite,
            ontapped: FavouriteScreen(),
          ),
          DrawerList(
            name: TextAllWidget.drawerTopBeats,
            icon: Icons.my_library_music_outlined,
            ontapped: TopBeatsScreen(),
          ),
          DrawerList(
            name: TextAllWidget.drawerSettings,
            icon: Icons.settings,
            ontapped: SettingsScreen(),
          ),
          DrawerList(
            name: TextAllWidget.drawerAbout,
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
