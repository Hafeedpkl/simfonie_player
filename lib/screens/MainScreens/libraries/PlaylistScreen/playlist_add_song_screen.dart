import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simfonie/db/playlistDb.dart';
import 'package:simfonie/model/simfonie_model.dart';
import 'package:simfonie/screens/MainScreens/searchSongsScreen.dart';

class SongListAddPage extends StatefulWidget {
  const SongListAddPage({super.key, required this.playlist});
  final SimfonieModel playlist;
  @override
  State<SongListAddPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 20, 5, 46),
        body: SafeArea(
          child: Stack(
            children: [
              Image.asset('assets/images/ellipse_favourite.png'),
              Column(
                children: [
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
                        'Add Song To Playlist',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'poppins'),
                      ),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 400,
                          width: double.infinity,
                          child: FutureBuilder<List<SongModel>>(
                              future: audioQuery.querySongs(
                                  sortType: null,
                                  orderType: OrderType.ASC_OR_SMALLER,
                                  uriType: UriType.EXTERNAL,
                                  ignoreCase: true),
                              builder: (context, item) {
                                if (item.data == null) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (item.data!.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'No Song Available',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'poppins'),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, right: 6),
                                      child: Card(
                                        color: const Color.fromARGB(
                                            255, 18, 2, 61),
                                        shadowColor: Colors.purpleAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 132, 0, 255))),
                                        child: ListTile(
                                            iconColor: Colors.white,
                                            selectedColor: Colors.purpleAccent,
                                            leading: QueryArtworkWidget(
                                                id: item.data![index].id,
                                                type: ArtworkType.AUDIO,
                                                nullArtworkWidget: const CircleAvatar(
                                                    radius: 27,
                                                    backgroundImage: AssetImage(
                                                        'assets/images/playlist.png'))),
                                            title: Text(
                                              item.data![index]
                                                  .displayNameWOExt,
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontFamily: 'poppins',
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              '${item.data![index].artist == "<unknown>" ? "Unknown Artist" : item.data![index].artist}',
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 12,
                                                  color: Colors.blueGrey),
                                            ),
                                            trailing: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Wrap(children: [
                                                !widget.playlist.isValueIn(
                                                        item.data![index].id)
                                                    ? IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            songAddPlaylist(item
                                                                .data![index]);
                                                            PlaylistDb
                                                                .playlistNotifiier
                                                                .notifyListeners();
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ))
                                                    : IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            widget.playlist
                                                                .deleteData(item
                                                                    .data![
                                                                        index]
                                                                    .id);
                                                          });
                                                          const snackBar =
                                                              SnackBar(
                                                            content: Text(
                                                              'Song deleted from playlist',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    450),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        },
                                                        icon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 25),
                                                          child: Icon(
                                                            Icons.minimize,
                                                            color: Colors.white,
                                                          ),
                                                        ))
                                              ]),
                                            )),
                                      ),
                                    );
                                  }),
                                  itemCount: item.data!.length,
                                );
                              })),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  void songAddPlaylist(SongModel data) {
    widget.playlist.add(data.id);

    const snackBar1 = SnackBar(
        content: Text(
      'Song added to Playlist',
      style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar1);
  }
}
