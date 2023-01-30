import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:simfonie/model/functions/playlistDb.dart';
import 'package:simfonie/model/model/simfonie_model.dart';
import 'package:simfonie/view/explore/view/libraries/PlaylistScreen/playlist_Individual.dart';

import '../FavouriteSongsScreen/favourites.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    int imageChanger = 1;
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
                  newplaylist(context, _formKey);
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
                color: Color.fromARGB(255, 42, 2, 61),
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
                  child: ValueListenableBuilder(
                      valueListenable:
                          Hive.box<SimfonieModel>('playlistDb').listenable(),
                      builder: (BuildContext context,
                          Box<SimfonieModel> musicList, Widget? child) {
                        return Hive.box<SimfonieModel>('playlistDb').isEmpty
                            ? Center(
                                child: Container(
                                  height: 300,
                                  width: 200,
                                  child: InkWell(
                                    onTap: () {
                                      newplaylist(context, _formKey);
                                    },
                                    child: Column(
                                      children: [
                                        Lottie.asset(
                                            'assets/lottie/add-new-playlist.json'),
                                        Text(
                                          'Click to add new Playlist',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              fontFamily: 'poppins'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemBuilder: ((context, index) {
                                  final data = musicList.values.toList()[index];
                                  imageChanger = Random().nextInt(5) + 1;

                                  // allSongs.addAll(items.data!);
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 6, bottom: 8),
                                    child: Card(
                                      color:
                                          const Color.fromARGB(255, 18, 2, 61),
                                      shadowColor: Colors.purpleAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 132, 0, 255))),
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            'assets/images/PlaylistScreen/playlist-small-playlistscreen$imageChanger.png',
                                            fit: BoxFit.fill,
                                            width: double.infinity,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlaylistSingle(
                                                      playlist: data,
                                                      findex: index,
                                                    ),
                                                  ));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(top: 40),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const SizedBox(
                                                      width: 40,
                                                    ),
                                                    Text(
                                                      data.name,
                                                      style: const TextStyle(
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  78, 0, 0, 0),
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25,
                                                          fontFamily:
                                                              'poppins'),
                                                    ),
                                                    PopupMenuButton(
                                                      color: Color.fromARGB(
                                                          255, 54, 1, 104),
                                                      icon: Icon(
                                                        Icons.more_vert,
                                                        color: Colors.white,
                                                      ),
                                                      itemBuilder: (context) =>
                                                          [
                                                        PopupMenuItem(
                                                          value: 1,
                                                          child: Text(
                                                            'Edit',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'poppins'),
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          value: 2,
                                                          child: Text(
                                                            'delete',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'poppins'),
                                                          ),
                                                        )
                                                      ],
                                                      onSelected: (value) {
                                                        if (value == 1) {
                                                          EditPlaylistName(
                                                              context,
                                                              data,
                                                              index);
                                                        } else if (value == 2) {
                                                          DeletePlaylist(
                                                              context,
                                                              musicList,
                                                              index);
                                                        }
                                                      },
                                                    )
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
                                itemCount: musicList.length,
                              );
                      })),
            ),
          )
        ]),
      ),
    );
  }
}

Future<dynamic> EditPlaylistName(
    BuildContext context, SimfonieModel data, int index) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: Color.fromARGB(255, 52, 6, 105),
      children: [
        SimpleDialogOption(
          child: Text(
            "Edit Playlist '${data.name}'",
            style: const TextStyle(
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
            key: _formKey,
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
                    color: Colors.purpleAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    return;
                  } else {
                    final playlistName = SimfonieModel(name: name, songId: []);
                    PlaylistDb.editList(index, playlistName);
                  }
                  nameController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Colors.purpleAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<dynamic> DeletePlaylist(
    BuildContext context, Box<SimfonieModel> musicList, int index) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 52, 6, 105),
        title: const Text(
          'Delete Playlist',
          style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
        ),
        content: const Text('Are you sure you want to delete this playlist?',
            style: TextStyle(color: Colors.white, fontFamily: 'poppins')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No',
                style: TextStyle(
                    color: Colors.purpleAccent, fontFamily: 'poppins')),
          ),
          TextButton(
            onPressed: () {
              musicList.deleteAt(index);
              Navigator.pop(context);
              const snackBar = SnackBar(
                backgroundColor: Colors.black,
                content: Text(
                  'Playlist is deleted',
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(milliseconds: 350),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Yes',
                style: TextStyle(
                    color: Colors.purpleAccent, fontFamily: 'poppins')),
          ),
        ],
      );
    },
  );
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
  final datas = PlaylistDb.playlistDb.values.map((e) => e.name.trim()).toList();
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
