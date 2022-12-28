import 'package:flutter/material.dart';
import 'package:simfonie/screens/MiniScreens/NowPlayingScreen/NowPlayingScreen.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../Controllers/Get_all_song_controller.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({
    Key? key,
  }) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

bool isPlaying = false;

class _MiniPlayerState extends State<MiniPlayer> {
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PlayScreen(songModelList: GetAllSongController.playingSong),
            ));
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purpleAccent, width: 2),
                color: const Color.fromARGB(255, 2, 3, 61)),
            height: 60,
            child: Stack(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isPlaying
                                ? Text(
                                    GetAllSongController
                                        .playingSong[GetAllSongController
                                            .audioPlayer.currentIndex!]
                                        .displayNameWOExt,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white,
                                        fontFamily: 'poppins',
                                        fontSize: 14),
                                  )
                                : TextScroll(
                                    GetAllSongController
                                        .playingSong[GetAllSongController
                                            .audioPlayer.currentIndex!]
                                        .displayNameWOExt,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'poppins',
                                        fontSize: 14),
                                  ),
                            TextScroll(
                              GetAllSongController
                                          .playingSong[GetAllSongController
                                              .audioPlayer.currentIndex!]
                                          .artist
                                          .toString() ==
                                      "<unknown>"
                                  ? "Unknown Artist"
                                  : GetAllSongController
                                      .playingSong[GetAllSongController
                                          .audioPlayer.currentIndex!]
                                      .artist
                                      .toString(),
                              style: const TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 10,
                                  color: Colors.blueGrey),
                              mode: TextScrollMode.endless,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        iconSize: 32,
                        onPressed: () async {
                          if (GetAllSongController.audioPlayer.hasPrevious) {
                            await GetAllSongController.audioPlayer
                                .seekToPrevious();
                            await GetAllSongController.audioPlayer.play();
                          } else {
                            await GetAllSongController.audioPlayer.play();
                          }
                        },
                        icon: const Icon(Icons.skip_previous),
                        color: Colors.white,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 2, 3, 61),
                            shape: const CircleBorder()),
                        onPressed: () async {
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                          if (GetAllSongController.audioPlayer.playing) {
                            await GetAllSongController.audioPlayer.pause();
                            setState(() {});
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
                              return const Icon(
                                Icons.pause_circle,
                                color: Colors.white,
                                size: 35,
                              );
                            } else {
                              return const Icon(
                                Icons.play_circle,
                                color: Colors.white,
                                size: 35,
                              );
                            }
                          },
                        ),
                      ),
                      IconButton(
                        iconSize: 35,
                        onPressed: () async {
                          if (GetAllSongController.audioPlayer.hasNext) {
                            await GetAllSongController.audioPlayer.seekToNext();
                            await GetAllSongController.audioPlayer.play();
                          } else {
                            await GetAllSongController.audioPlayer.play();
                          }
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          size: 32,
                        ),
                        color: Colors.white,
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class MiniPlayer extends StatefulWidget {
//   const MiniPlayer({super.key});

//   @override
//   State<MiniPlayer> createState() => _MiniPlayerState();
// }

// class _MiniPlayerState extends State<MiniPlayer> {
//   @override
//   void initState() {
//     GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
//       if (index != null && mounted) {
//         setState(() {});
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       tileColor: const Color.fromARGB(255, 151, 195, 249),
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => PlayScreen(
//               songModelList: GetAllSongController.playingSong,
//             ),
//           ),
//         );
//       },
//       leading: Padding(
//         padding: const EdgeInsets.only(left: 10),
//         child: QueryArtworkWidget(
//           id: GetAllSongController
//               .playingSong[GetAllSongController.audioPlayer.currentIndex!].id,
//           type: ArtworkType.AUDIO,
//           nullArtworkWidget: const Padding(
//             padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
//             child: Icon(Icons.music_note),
//           ),
//         ),
//       ),
//       title: AnimatedText(
//         text: GetAllSongController
//             .playingSong[GetAllSongController.audioPlayer.currentIndex!]
//             .displayNameWOExt,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 15,
//         ),
//       ),
//       subtitle: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Text(
//           "${GetAllSongController.playingSong[GetAllSongController.audioPlayer.currentIndex!].artist}",
//           maxLines: 1,
//           style: const TextStyle(fontSize: 11, overflow: TextOverflow.ellipsis),
//         ),
//       ),
//       trailing: FittedBox(
//         fit: BoxFit.fill,
//         child: Row(
//           children: [
//             IconButton(
//                 onPressed: () async {
//                   if (GetAllSongController.audioPlayer.hasPrevious) {
//                     await GetAllSongController.audioPlayer.seekToPrevious();
//                     await GetAllSongController.audioPlayer.play();
//                   } else {
//                     await GetAllSongController.audioPlayer.play();
//                   }
//                 },
//                 icon: const Icon(
//                   Icons.skip_previous,
//                   size: 35,
//                   color: Colors.black,
//                 )),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red.shade600,
//                   shape: const CircleBorder()),
//               onPressed: () async {
//                 if (GetAllSongController.audioPlayer.playing) {
//                   await GetAllSongController.audioPlayer.pause();
//                   setState(() {});
//                 } else {
//                   await GetAllSongController.audioPlayer.play();
//                   setState(() {});
//                 }
//               },
//               child: StreamBuilder<bool>(
//                 stream: GetAllSongController.audioPlayer.playingStream,
//                 builder: (context, snapshot) {
//                   bool? playingStage = snapshot.data;
//                   if (playingStage != null && playingStage) {
//                     return const Icon(
//                       Icons.pause,
//                       color: Colors.white,
//                       size: 35,
//                     );
//                   } else {
//                     return const Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 35,
//                     );
//                   }
//                 },
//               ),
//             ),
//             IconButton(
//                 onPressed: (() async {
//                   if (GetAllSongController.audioPlayer.hasNext) {
//                     await GetAllSongController.audioPlayer.seekToNext();
//                     await GetAllSongController.audioPlayer.play();
//                   } else {
//                     await GetAllSongController.audioPlayer.play();
//                   }
//                 }),
//                 icon: const Icon(
//                   Icons.skip_next,
//                   size: 35,
//                   color: Colors.black,
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

