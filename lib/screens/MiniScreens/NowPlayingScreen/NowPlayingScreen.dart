// ignore_for_file: file_names
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simfonie/db/favourite_db.dart';
import 'package:simfonie/screens/MainScreens/BottomNavScreen.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../Controllers/Get_all_song_controller.dart';
import '../../../Controllers/get_recent_song_controller.dart';
import '../../../db/playlistDb.dart';
import '../../../model/simfonie_model.dart';
import '../../MainScreens/libraries/FavouriteSongsScreen/fav_but_music_playing.dart';
import '../../MainScreens/libraries/PlaylistScreen/PlaylistScreen.dart';
import 'widgets/ArtWorkWidget.dart';

class PlayScreen extends StatefulWidget {
  PlayScreen({super.key, required this.songModelList, this.count = 0});
  final List<SongModel> songModelList;
  int count;

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _PlayScreenState extends State<PlayScreen> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _firstsong = false;
  bool _lastSong = false;
  int large = 0;
  bool _isShuffling = false;
  List<AudioSource> songList = [];
  int currentIndex = 0;
  List<int> topBeatSongCounterList = [];
  int topBeatsCounter = 0;
  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        setState(() {
          topBeatsCounter++;

          large = widget.count - 1; //store the last song's index number

          currentIndex = index;
          index == 0 ? _firstsong = true : _firstsong = false;
          index == large ? _lastSong = true : _lastSong = false;
        });
        GetAllSongController.currentIndexes = index;
        log('index of last song ${widget.count}');
      }
    });
    super.initState();
    playSong();
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
  }

  void playSong() {
    GetAllSongController.audioPlayer.play();
    GetAllSongController.audioPlayer.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });
    GetAllSongController.audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 20, 5, 46),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/ellipse_blue_main_center.png',
                  height: 600,
                  width: 500,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ScreenHome(),
                                  ));
                              FavoriteDb.favoriteSongs.notifyListeners();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const Text(
                            'Now Playing',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: 'poppins'),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PlaylistScreen(),
                                  ));
                            },
                            icon: const Icon(
                              Icons.playlist_play,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Center(
                      child: CircleAvatar(
                        radius: 120,
                        backgroundColor: Color.fromARGB(255, 20, 5, 46),
                        child: ArtWorkWidget(),
                      ),
                    ),
                    //
                    const SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: TextScroll(
                        widget.songModelList[currentIndex].displayNameWOExt,
                        style: const TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        mode: TextScrollMode.bouncing,
                        pauseBetween: const Duration(seconds: 2),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FavButMusicPlaying(
                            songFavoriteMusicPlaying:
                                widget.songModelList[currentIndex]),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 250,
                          child: Center(
                            child: TextScroll(
                              widget.songModelList[currentIndex].artist
                                          .toString() ==
                                      "<unknown>"
                                  ? "Unknown Artist"
                                  : widget.songModelList[currentIndex].artist
                                      .toString(),
                              style: const TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.white54,
                                fontSize: 15,
                              ),
                              mode: TextScrollMode.endless,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              showPlaylistdialog(context);
                            },
                            icon: const Icon(
                              Icons.playlist_add,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    thumbColor: Colors.transparent,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 0)),
                                child: Slider(
                                  activeColor: Colors.purpleAccent,
                                  inactiveColor: Colors.white38,
                                  min: const Duration(microseconds: 0)
                                      .inSeconds
                                      .toDouble(),
                                  value: _position.inSeconds.toDouble(),
                                  max: _duration.inSeconds.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      ChangeToSeconds(value.toInt());
                                      value = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(_position),
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: 'poppins')),
                          Text(_formatDuration(_duration),
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: 'poppins')),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isShuffling == false
                                  ? GetAllSongController.audioPlayer
                                      .setShuffleModeEnabled(true)
                                  : GetAllSongController.audioPlayer
                                      .setShuffleModeEnabled(false);
                            });
                          },
                          icon: StreamBuilder<bool>(
                            stream: GetAllSongController
                                .audioPlayer.shuffleModeEnabledStream,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              _isShuffling = snapshot.data;
                              if (_isShuffling) {
                                return const Icon(
                                  Icons.shuffle_rounded,
                                  color: Colors.purpleAccent,
                                );
                              } else {
                                return const Icon(
                                  Icons.shuffle_rounded,
                                  color: Colors.white,
                                );
                              }
                            },
                          ),
                        ),
                        _firstsong
                            ? const IconButton(
                                iconSize: 40,
                                onPressed: null,
                                icon: Icon(
                                  Icons.skip_previous_outlined,
                                  color: Color.fromARGB(210, 102, 94, 121),
                                ))
                            : IconButton(
                                iconSize: 40,
                                onPressed: () {
                                  if (GetAllSongController
                                      .audioPlayer.hasPrevious) {
                                    GetAllSongController.audioPlayer
                                        .seekToPrevious();
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_previous_outlined,
                                  color: Colors.white,
                                )),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 20, 5, 46),
                              shape: const CircleBorder()),
                          onPressed: () async {
                            GetRecentSongController.addRecentlyPlayed(
                                widget.songModelList[currentIndex].id);
                            if (GetAllSongController.audioPlayer.playing) {
                              setState(() {});
                              await GetAllSongController.audioPlayer.pause();
                            } else {
                              await GetAllSongController.audioPlayer.play();
                              setState(() {});
                            }
                          },
                          child: StreamBuilder<bool>(
                            stream:
                                GetAllSongController.audioPlayer.playingStream,
                            builder: (context, snapshot) {
                              bool? playingStage = snapshot.data;
                              if (playingStage != null && playingStage) {
                                return const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.pause_circle,
                                    color: Colors.purpleAccent,
                                    size: 80,
                                  ),
                                );
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.play_circle,
                                    color: Colors.purpleAccent,
                                    size: 80,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        _lastSong
                            ? const IconButton(
                                iconSize: 40,
                                onPressed: null,
                                icon: Icon(
                                  Icons.skip_next_outlined,
                                  color: Color.fromARGB(210, 102, 94, 121),
                                ))
                            : IconButton(
                                iconSize: 40,
                                onPressed: () {
                                  if (GetAllSongController
                                      .audioPlayer.hasNext) {
                                    GetAllSongController.audioPlayer
                                        .seekToNext();
                                  }
                                },
                                icon: const Icon(
                                  Icons.skip_next_outlined,
                                  color: Colors.white,
                                )),
                        IconButton(
                          onPressed: () {
                            GetAllSongController.audioPlayer.loopMode ==
                                    LoopMode.one
                                ? GetAllSongController.audioPlayer
                                    .setLoopMode(LoopMode.all)
                                : GetAllSongController.audioPlayer
                                    .setLoopMode(LoopMode.one);
                            GetRecentSongController.addRecentlyPlayed(
                                widget.songModelList[currentIndex].id);
                          },
                          icon: StreamBuilder<LoopMode>(
                            stream:
                                GetAllSongController.audioPlayer.loopModeStream,
                            builder: (context, snapshot) {
                              final loopMode = snapshot.data;
                              if (LoopMode.one == loopMode) {
                                return const Icon(Icons.repeat,
                                    color: Colors.purpleAccent);
                              } else {
                                return const Icon(
                                  Icons.repeat,
                                  color: Colors.white,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Center(
                  child: Text(
                    '$topBeatsCounter',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  showPlaylistdialog(context) {
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
                                        widget.songModelList[currentIndex],
                                        data,
                                        data.name);
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
          duration: const Duration(milliseconds: 850),
          backgroundColor: Colors.black,
          content: Text(
            'Song added to $name',
            style: const TextStyle(color: Colors.greenAccent),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar1);
    } else {
      final snackbar2 = SnackBar(
          duration: const Duration(milliseconds: 850),
          backgroundColor: Colors.black,
          content: Text(
            'Song already added in $name',
            style: const TextStyle(color: Colors.redAccent),
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
        backgroundColor: const Color.fromARGB(255, 52, 6, 105),
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
                    counterStyle: const TextStyle(
                        color: Colors.white, fontFamily: 'poppins'),
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

  // ignore: non_constant_identifier_names
  void ChangeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
  }
}
