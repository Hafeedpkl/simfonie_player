import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simfonie/model/simfonie_model.dart';

class PlaylistDb {
  static ValueNotifier<List<SimfonieModel>> playlistNotifier =
      ValueNotifier([]);
  static final playlistDb = Hive.box<SimfonieModel>('playlistDb');
  static Future<void> addPlaylist(SimfonieModel value) async {
    final playlistDb = Hive.box<SimfonieModel>('playlistDb');
    await playlistDb.add(value);
    playlistNotifier.value.add(value);
    getAllPlaylist();
    log('addPlaylist');
  }

  static Future<void> getAllPlaylist() async {
    final playlistDb = Hive.box<SimfonieModel>('playlistDb');
    playlistNotifier.value.clear();
    playlistNotifier.value.addAll(playlistDb.values);
    playlistNotifier.notifyListeners();
    log('getAllPlaylist');
  }

  static Future<void> deletePlaylist(int index) async {
    final playlistDb = Hive.box<SimfonieModel>('playlistDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> editList(int id, SimfonieModel value) async {
    final playlistDb = Hive.box<SimfonieModel>('editPlaylistDb');
    await playlistDb.put(id, value);
    getAllPlaylist();
  }
}
