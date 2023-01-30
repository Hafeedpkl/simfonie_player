import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simfonie/model/model/simfonie_model.dart';

class PlaylistDb {
  static ValueNotifier<List<SimfonieModel>> playlistNotifiier =
      ValueNotifier([]);
  static final playlistDb = Hive.box<SimfonieModel>('playlistDb');

  static Future<void> addPlaylist(SimfonieModel value) async {
    final playlistDb = Hive.box<SimfonieModel>('playlistDb');
    await playlistDb.add(value);
    playlistNotifiier.value.add(value);
  }

  static Future<void> getAllPlaylist() async {
    final playlistDb = Hive.box<SimfonieModel>('playlistDb');
    playlistNotifiier.value.clear();
    playlistNotifiier.value.addAll(playlistDb.values);
    playlistNotifiier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    final playlistDb = Hive.box<SimfonieModel>('playlistDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> editList(int index, SimfonieModel value) async {
    final playlistDb = Hive.box<SimfonieModel>('playlistDb');
    await playlistDb.putAt(index, value);
    getAllPlaylist();
  }
}
