import 'package:flutter/material.dart';
import 'package:simfonie/view/explore/view/libraries/libraryWidget.dart';
import 'package:simfonie/view/explore/view/libraries/recently/recently_played_widget.dart';
import '../../widgets/Drawer/DrawerWidget.dart';

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
                  child: RecentlyPlayedWidget())
            ]),
          ),
        ));
  }
}
