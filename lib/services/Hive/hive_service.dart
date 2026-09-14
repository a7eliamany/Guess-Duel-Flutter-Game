import 'package:guess_duel/models/Attempts/attempts_type_adabter.dart';
import 'package:guess_duel/models/History/history_adabter.dart';
import 'package:guess_duel/models/Players/players_type_adabter.dart';
import 'package:guess_duel/models/Room%20Settings/room_settings_adapter.dart';
import 'package:guess_duel/models/Rooms/rooms_type_adabter.dart';
import 'package:guess_duel/models/offline/offline_game_adabter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    // register adapters
    Hive.registerAdapter(RoomsTypeAdabter()); // 0
    Hive.registerAdapter(AttemptsTypeAdabter()); // 1
    Hive.registerAdapter(RoomPlayerCacheAdapter()); // 2
    Hive.registerAdapter(HistoryAdabter()); // 3
    Hive.registerAdapter(StatsAdapter()); // 4
    Hive.registerAdapter(OfflineGameAdapter()); // 5
    Hive.registerAdapter(RoomSettingsAdapter()); // 6

    // remove old boxes
    await Hive.deleteBoxFromDisk(HiveBoxes.rooms);
    await Hive.deleteBoxFromDisk(HiveBoxes.roomSettings);
    await Hive.deleteBoxFromDisk(HiveBoxes.players);
    await Hive.deleteBoxFromDisk(HiveBoxes.attempts);

    // open boxes
    await Hive.openBox(HiveBoxes.rooms);
    await Hive.openBox(HiveBoxes.players);
    await Hive.openBox(HiveBoxes.attempts);
    await Hive.openBox(HiveBoxes.gameHistory);
    await Hive.openBox(HiveBoxes.recentGameHistory);
    await Hive.openBox(HiveBoxes.stats);
    await Hive.openBox(HiveBoxes.offlineGame);
    await Hive.openBox(HiveBoxes.roomSettings);
    await Hive.openBox(HiveBoxes.userData);
  }

  static Box get playersBox => Hive.box(HiveBoxes.players);
  static Box get roomsBox => Hive.box(HiveBoxes.rooms);
  static Box get roomSettings => Hive.box(HiveBoxes.roomSettings);
  static Box get attemptsBox => Hive.box(HiveBoxes.attempts);
  static Box get gameHistoryBox => Hive.box(HiveBoxes.gameHistory);
  static Box get recentGameHistoryBox => Hive.box(HiveBoxes.recentGameHistory);
  static Box get statsBox => Hive.box(HiveBoxes.stats);
  static Box get offlineGameBox => Hive.box(HiveBoxes.offlineGame);
  static Box get userData => Hive.box(HiveBoxes.userData);

  static Future<void> clearStoragePlayers(String roomID) async {
    await playersBox.delete(roomID);
    await playersBox.delete(HiveBoxPlayers.currentPlayer(roomID));
    await playersBox.delete(HiveBoxPlayers.opponentPlayer(roomID));
  }

  static Future<void> clearStorageRoom(String roomID) async {
    await roomsBox.delete(roomID);
  }

  static Future<void> clearStorageAttempts(String roomID) async {
    await attemptsBox.delete(roomID);
  }

  static Future<void> clearStorageAll(String roomID) async {
    // delete room data

    await clearStorageRoom(roomID);

    // delete attempts data

    await clearStorageAttempts(roomID);

    // delete players data

    await clearStoragePlayers(roomID);
  }
}

class HiveBoxes {
  static const players = 'Players';
  static const rooms = 'Rooms';
  static const attempts = 'Attempts';
  static const gameHistory = 'GameHistory';
  static const stats = 'Stats';
  static const offlineGame = 'OfflineGame';
  static const roomSettings = 'roomSettings';
  static const userData = 'userData';
  static const recentGameHistory = 'recentGameHistory';
}

class HiveBoxPlayers {
  static String currentPlayer(String roomID) {
    return '${roomID}_current';
  }

  static String opponentPlayer(String roomID) {
    return '${roomID}_opponent';
  }
}
