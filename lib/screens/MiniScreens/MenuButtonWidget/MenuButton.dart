import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simfonie/db/favourite_db.dart';
import 'package:simfonie/screens/MainScreens/songListScreen.dart';

import '../../../db/playlistDb.dart';
import '../../../model/simfonie_model.dart';

// PLAYLIST ADDING SHORTCUT INCLUDED
class FavoriteMenuButton extends StatefulWidget {
  const FavoriteMenuButton(
      {super.key, required this.songFavorite, this.findex});
  final SongModel songFavorite;
  final findex;
  @override
  State<FavoriteMenuButton> createState() => _FavoriteMenuButtonState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();

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
            const PopupMenuItem(
                child: Text(
                  'Add to playlists',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'poppins', fontSize: 13),
                ),
                value: 2)
          ],
          onSelected: (value) {
            if (value == 2) {
              showPlaylistdialog(context);
            }
          },
          color: Color.fromARGB(255, 37, 5, 92),
          elevation: 2,
        );
      },
    );
  }

  showPlaylistdialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 52, 6, 105),
            title: const Text(
              "choose your playlist",
              style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
            ),
            content: SizedBox(
              height: 200,
              width: double.maxFinite,
              child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<SimfonieModel>('playlistDb').listenable(),
                  builder: (BuildContext context, Box<SimfonieModel> musicList,
                      Widget? child) {
                    return Hive.box<SimfonieModel>('playlistDb').isEmpty
                        ? Center(
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Lottie.asset(
                                      'assets/lottie/1725-not-found.json'),
                                ),
                                const Positioned(
                                  right: 30,
                                  left: 30,
                                  bottom: 50,
                                  child: Text('No Playlist found!',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          fontFamily: 'poppins')),
                                )
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: musicList.length,
                            itemBuilder: (context, index) {
                              final data = musicList.values.toList()[index];

                              return Card(
                                color: const Color.fromARGB(255, 51, 2, 114),
                                shadowColor: Colors.purpleAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side:
                                        const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: Text(
                                    data.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'poppins'),
                                  ),
                                  trailing: const Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    songAddToPlaylist(
                                        startSong[index], data, data.name);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          );
                  }),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    newplaylist(context, _formKey);
                  },
                  child: const Text(
                    'New Playlist',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'poppins'),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'cancel',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'poppins'),
                  ))
            ],
          );
        });
  }

  void songAddToPlaylist(SongModel data, datas, String name) {
    if (!datas.isValueIn(data.id)) {
      datas.add(data.id);
      final snackbar1 = SnackBar(
          duration: Duration(milliseconds: 850),
          backgroundColor: Colors.black,
          content: Text(
            'Song added to $name',
            style: TextStyle(color: Colors.greenAccent),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar1);
    } else {
      final snackbar2 = SnackBar(
          duration: Duration(milliseconds: 850),
          backgroundColor: Colors.black,
          content: Text(
            'Song already in $name',
            style: TextStyle(color: Colors.redAccent),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar2);
    }
  }

  Future newplaylist(BuildContext context, formKey) {
    return showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: Color.fromARGB(255, 52, 6, 105),
        children: [
          const SimpleDialogOption(
            child: Text(
              'New to Playlist',
              style: TextStyle(
                  fontFamily: 'poppins',
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SimpleDialogOption(
            child: Form(
              key: formKey,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: nameController,
                maxLength: 15,
                decoration: InputDecoration(
                    counterStyle:
                        TextStyle(color: Colors.white, fontFamily: 'poppins'),
                    fillColor: Colors.white.withOpacity(0.7),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.only(left: 15, top: 5)),
                style: const TextStyle(
                    fontFamily: 'poppins',
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your playlist name";
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  nameController.clear();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveButtonPressed(context);
                  }
                },
                child: const Text(
                  'Create',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> saveButtonPressed(context) async {
    final name = nameController.text.trim();
    final music = SimfonieModel(name: name, songId: []);
    final datas =
        PlaylistDb.playlistDb.values.map((e) => e.name.trim()).toList();
    if (name.isEmpty) {
      return;
    } else if (datas.contains(music.name)) {
      const snackbar3 = SnackBar(
          duration: Duration(milliseconds: 750),
          backgroundColor: Colors.black,
          content: Text(
            'playlist already exist',
            style: TextStyle(color: Colors.redAccent),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar3);
      Navigator.of(context).pop();
    } else {
      PlaylistDb.addPlaylist(music);
      const snackbar4 = SnackBar(
          duration: Duration(milliseconds: 750),
          backgroundColor: Colors.black,
          content: Text(
            'playlist created successfully',
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar4);
      Navigator.pop(context);
      nameController.clear();
    }
  }
}
