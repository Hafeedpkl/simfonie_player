import 'package:flutter/material.dart';
import 'package:simfonie/screens/MainScreens/ExploreScreen/libraryWidget.dart';
import '../../MiniScreens/widgets/DrawerWidget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: Center(
            child: Image.asset(
              'assets/images/simfonie_image.png',
              scale: 1.3,
              // height: 50,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 20, 5, 46),
          actions: const [
            SizedBox(
              width: 30,
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 20, 5, 46),
        body: SafeArea(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 20,
              ),
              const LibraryWidget(),
              const Text(
                "   Recent songs",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
              SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      // allSongs.addAll(items.data!);
                      return Padding(
                        padding: const EdgeInsets.only(left: 6, right: 6),
                        child: Card(
                          color: const Color.fromARGB(255, 18, 2, 61),
                          shadowColor: Colors.purpleAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 132, 0, 255))),
                          child: ListTile(
                            iconColor: Colors.white,
                            selectedColor: Colors.purpleAccent,
                            leading: const CircleAvatar(
                                radius: 27,
                                backgroundImage:
                                    AssetImage('assets/images/playlist.png')),
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
                              icon: const Icon(Icons.favorite_outline),
                              onPressed: () {},
                            ),
                            onTap: () {},
                          ),
                        ),
                      );
                    }),
                    itemCount: 10,
                  ))
            ]),
          ),
        ));
  }
}
