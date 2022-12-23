import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../Controllers/Get_all_song_controller.dart';
import '../../../styles/text_animation.dart';
import '../NowPlayingScreen/NowPlayingScreen.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
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
    return ListTile(
      tileColor: const Color.fromARGB(255, 151, 195, 249),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlayScreen(
              songModelList: GetAllSongController.playingSong,
            ),
          ),
        );
      },
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: QueryArtworkWidget(
          id: GetAllSongController
              .playingSong[GetAllSongController.audioPlayer.currentIndex!].id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget: const Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: Icon(Icons.music_note),
          ),
        ),
      ),
      title: AnimatedText(
        text: GetAllSongController
            .playingSong[GetAllSongController.audioPlayer.currentIndex!]
            .displayNameWOExt,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          "${GetAllSongController.playingSong[GetAllSongController.audioPlayer.currentIndex!].artist}",
          maxLines: 1,
          style: const TextStyle(fontSize: 11, overflow: TextOverflow.ellipsis),
        ),
      ),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
                onPressed: () async {
                  if (GetAllSongController.audioPlayer.hasPrevious) {
                    await GetAllSongController.audioPlayer.seekToPrevious();
                    await GetAllSongController.audioPlayer.play();
                  } else {
                    await GetAllSongController.audioPlayer.play();
                  }
                },
                icon: const Icon(
                  Icons.skip_previous,
                  size: 35,
                  color: Colors.black,
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  shape: const CircleBorder()),
              onPressed: () async {
                if (GetAllSongController.audioPlayer.playing) {
                  await GetAllSongController.audioPlayer.pause();
                  setState(() {});
                } else {
                  await GetAllSongController.audioPlayer.play();
                  setState(() {});
                }
              },
              child: StreamBuilder<bool>(
                stream: GetAllSongController.audioPlayer.playingStream,
                builder: (context, snapshot) {
                  bool? playingStage = snapshot.data;
                  if (playingStage != null && playingStage) {
                    return const Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 35,
                    );
                  } else {
                    return const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 35,
                    );
                  }
                },
              ),
            ),
            IconButton(
                onPressed: (() async {
                  if (GetAllSongController.audioPlayer.hasNext) {
                    await GetAllSongController.audioPlayer.seekToNext();
                    await GetAllSongController.audioPlayer.play();
                  } else {
                    await GetAllSongController.audioPlayer.play();
                  }
                }),
                icon: const Icon(
                  Icons.skip_next,
                  size: 35,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }
}










// class MiniPlayer extends StatefulWidget {
//   const MiniPlayer({
//     Key? key,
//     required this.allSongs,
//     required AudioPlayer audioPlayer,
//   })  : _audioPlayer = audioPlayer,
//         super(key: key);

//   final List<SongModel> allSongs;
//   final AudioPlayer _audioPlayer;

//   @override
//   State<MiniPlayer> createState() => _MiniPlayerState();
// }

// class _MiniPlayerState extends State<MiniPlayer> {
//   @override
//   bool _isplaying = false;

//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => PlayScreen(
//                       songModelList: widget.allSongs,
//                       audioPlayer: widget._audioPlayer,
//                     )));
//       },
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.purpleAccent, width: 2),
//                 color: Color.fromARGB(255, 2, 3, 61)),
//             height: 60,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   const SizedBox(
//                     width: 200,
//                     child: Text(
//                       'Your song',
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'poppins',
//                           fontSize: 15),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.favorite_outline),
//                     color: Colors.white,
//                   ),
//                   IconButton(
//                     iconSize: 35,
//                     onPressed: () {
//                       setState(() {
//                         if (_isplaying) {
//                           widget._audioPlayer.pause();
//                         } else {
//                           widget._audioPlayer.play();
//                         }
//                         _isplaying = !_isplaying;
//                       });
//                     },
//                     icon: _isplaying
//                         ? Icon(Icons.pause_rounded)
//                         : Icon(Icons.play_arrow_rounded),
//                     color: Colors.white,
//                   ),
//                   IconButton(
//                     iconSize: 35,
//                     onPressed: () {
//                       if (widget._audioPlayer.hasNext) {
//                         widget._audioPlayer.seekToNext();
//                       }
//                     },
//                     icon: Icon(Icons.skip_next),
//                     color: Colors.white,
//                   ),
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
