

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// import '../../../../model/simfonie_model.dart';
// import '../../songListScreen.dart';

// class PlaylistButton  {

//    showPlaylistdialog( widget.son) {
//     showDialog(
//         context: context,
//         builder: (_) {
//           return AlertDialog(
//             backgroundColor: Color.fromARGB(255, 52, 6, 105),
//             title: Text(
//               "choose your playlist",
//               style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
//             ),
//             content: SizedBox(
//               height: 200,
//               width: double.maxFinite,
//               child: ValueListenableBuilder(
//                   valueListenable:
//                       Hive.box<SimfonieModel>('playlistDb').listenable(),
//                   builder: (BuildContext context, Box<SimfonieModel> musicList,
//                       Widget? child) {
//                     return ListView.builder(
//                       itemCount: musicList.length,
//                       itemBuilder: (context, index) {
//                         final data = musicList.values.toList()[index];

//                         return Card(
//                           color: Color.fromARGB(255, 51, 2, 114),
//                           shadowColor: Colors.purpleAccent,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               side: const BorderSide(color: Colors.white)),
//                           child: ListTile(
//                             title: Text(
//                               data.name,
//                               style: TextStyle(
//                                   color: Colors.white, fontFamily: 'poppins'),
//                             ),
//                             trailing: Icon(
//                               Icons.playlist_add,
//                               color: Colors.white,
//                             ),
//                             onTap: () {
//                               songAddToPlaylist(startSong[index], data);
//                               Navigator.pop(context);
//                             },
//                           ),
//                         );
//                       },
//                     );
//                   }),
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                     'cancel',
//                     style:
//                         TextStyle(color: Colors.white, fontFamily: 'poppins'),
//                   ))
//             ],
//           );
//         });
//   }

//   void songAddToPlaylist(SongModel data, datas) {
//     if (!datas.isValueIn(data.id)) {
//       datas.add(data.id);
//       const snackbar1 = SnackBar(
//           duration: Duration(milliseconds: 850),
//           backgroundColor: Colors.black,
//           content: Text(
//             'Song added to Playlist',
//             style: TextStyle(color: Colors.greenAccent),
//           ));
//       ScaffoldMessenger.of(context).showSnackBar(snackbar1);
//     } else {
//       const snackbar2 = SnackBar(
//           duration: Duration(milliseconds: 850),
//           backgroundColor: Colors.black,
//           content: Text(
//             'Song already added to this playlist',
//             style: TextStyle(color: Colors.redAccent),
//           ));
//       ScaffoldMessenger.of(context).showSnackBar(snackbar2);
//     }
//   }

// }