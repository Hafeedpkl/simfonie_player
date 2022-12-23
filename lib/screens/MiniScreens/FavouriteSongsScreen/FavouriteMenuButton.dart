import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simfonie/db/favourite_db.dart';

class FavoriteMenuButton extends StatefulWidget {
  const FavoriteMenuButton({super.key, required this.songFavorite});
  final SongModel songFavorite;
  @override
  State<FavoriteMenuButton> createState() => _FavoriteMenuButtonState();
}



class _FavoriteMenuButtonState extends State<FavoriteMenuButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FavoriteDb.favoriteSongs,
      builder: (BuildContext ctx, List<SongModel> favoriteData, Widget? child) {
        return PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                  FavoriteDb.isFavor(widget.songFavorite)
                      ? 'Remove from favourites'
                      : 'Add to favourite',
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'poppins',
                      fontSize: 13)),
              onTap: () {
                if (FavoriteDb.isFavor(widget.songFavorite)) {
                  FavoriteDb.delete(widget.songFavorite.id);
                  const snackBar = SnackBar(
                    content: Text('Removed From Favorite'),
                    duration: Duration(seconds: 1),
                    backgroundColor: Color.fromARGB(255, 20, 5, 46),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  FavoriteDb.add(widget.songFavorite);
                  const snackBar = SnackBar(
                    content: Text('Song Added to Favorite'),
                    duration: Duration(seconds: 1),
                    backgroundColor: Color.fromARGB(255, 20, 5, 46),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                FavoriteDb.favoriteSongs.notifyListeners();
              },
            ),
            PopupMenuItem(
              child: Text(
                'Add to playlists',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'poppins', fontSize: 13),
              ),
              // value: PlaylistScreen(),
            )
          ],
          color: Color.fromARGB(255, 37, 5, 92),
          elevation: 2,
        );
      },
    );
  }
}
