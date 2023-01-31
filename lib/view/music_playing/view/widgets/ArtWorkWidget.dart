import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../provider/song_model_provider.dart';

class ArtWorkWidget extends StatelessWidget {
  const ArtWorkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: context.watch<SongModelProvider>().id,
      type: ArtworkType.AUDIO,
      artworkHeight: 200,
      artworkWidth: 200,
      artworkFit: BoxFit.cover,
      nullArtworkWidget: const CircleAvatar(
        radius: 120,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(
          'assets/images/playlist.png',
        ),
      ),
    );
  }
}
