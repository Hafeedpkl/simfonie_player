import 'package:flutter/material.dart';

class PlaylistSingle extends StatelessWidget {
  final String playListName;

  const PlaylistSingle({super.key, required this.playListName});

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
                      Text(
                        playListName,
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
                          child: ListView.builder(
                            itemBuilder: ((context, index) {
                              // allSongs.addAll(items.data!);
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Card(
                                  color: const Color.fromARGB(255, 18, 2, 61),
                                  shadowColor: Colors.purpleAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 132, 0, 255))),
                                  child: ListTile(
                                    iconColor: Colors.white,
                                    selectedColor: Colors.purpleAccent,
                                    leading: CircleAvatar(
                                        radius: 27,
                                        backgroundImage: AssetImage(
                                            'assets/images/playlist.png')),
                                    title: Text(
                                      'Song $index',
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontFamily: 'poppins',
                                          color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      'artist $index',
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontSize: 12,
                                          color: Colors.blueGrey),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.more_vert),
                                      onPressed: () {},
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              );
                            }),
                            itemCount: 10,
                          )),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
