import 'package:guess_duel/models/Attempts/attempts_type_adabter.dart';
import 'package:guess_duel/models/History/history_adabter.dart';
import 'package:guess_duel/models/Players/players_type_adabter.dart';
import 'package:guess_duel/models/Rooms/rooms_type_adabter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    // register adapters
    Hive.registerAdapter(RoomsTypeAdabter());
    Hive.registerAdapter(AttemptsTypeAdabter());
    Hive.registerAdapter(RoomPlayerCacheAdapter());
    Hive.registerAdapter(HistoryAdabter());
    Hive.registerAdapter(StatsAdapter());

    // remove old boxes
    await Hive.deleteBoxFromDisk(HiveBoxes.rooms);
    await Hive.deleteBoxFromDisk(HiveBoxes.players);
    await Hive.deleteBoxFromDisk(HiveBoxes.attempts);

    // open boxes
    await Hive.openBox(HiveBoxes.players);
    await Hive.openBox(HiveBoxes.rooms);
    await Hive.openBox(HiveBoxes.attempts);
    await Hive.openBox(HiveBoxes.gameHistory);
    await Hive.openBox(HiveBoxes.stats);
  }

  static Box get playersBox => Hive.box(HiveBoxes.players);
  static Box get roomsBox => Hive.box(HiveBoxes.rooms);
  static Box get attemptsBox => Hive.box(HiveBoxes.attempts);
  static Box get gameHistoryBox => Hive.box(HiveBoxes.gameHistory);
  static Box get statsBox => Hive.box(HiveBoxes.stats);

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
}

class HiveBoxPlayers {
  static String currentPlayer(String roomID) {
    return '${roomID}_current';
  }

  static String opponentPlayer(String roomID) {
    return '${roomID}_opponent';
  }
}
