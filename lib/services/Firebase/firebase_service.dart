import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';
import 'package:guess_duel/models/app_config_model.dart';
import 'package:guess_duel/models/Room%20Settings/room_settings_model.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';

class FirebaseService {
  static Future<void> initialize(FirebaseOptions options) async {
    await Firebase.initializeApp(options: options);
  }

  static Future<void> signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static bool isUserSignedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<void> updateDisplayName(String displayName) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
    }
  }

  static CollectionReference<Map<String, dynamic>> getCollection(
    String collectionName,
  ) {
    final CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection(collectionName);
    return collectionReference;
  }

  static Future<RoomModel?> getRoomData(String roomID) async {
    try {
      final room = await FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomID)
          .get();
      return RoomModel.fromFirestore(room, null);
    } catch (e) {
      return null;
    }
  }

  static Future<List<RoomPlayer>> getPeopleRoomData(String roomID) async {
    final playersData = await FirebaseFirestore.instance
        .collection(FirebaseCollections.rooms)
        .doc(roomID)
        .collection(FirebaseCollections.roomPeople)
        .get();
    final List<RoomPlayer> players = playersData.docs
        .map((playermodel) => RoomPlayer.fromFirestore(playermodel.data()))
        .toList();
    return players;
  }

  static Future<RoomPlayer> getRoomPlayerData(
    String roomID,
    String firebaseID,
  ) async {
    final playersData = await FirebaseFirestore.instance
        .collection(FirebaseCollections.rooms)
        .doc(roomID)
        .collection(FirebaseCollections.roomPeople)
        .doc(firebaseID)
        .get();
    final RoomPlayer roomPlayer = RoomPlayer.fromFirestore(playersData.data()!);
    return roomPlayer;
  }

  static Future<bool> checkUserHost(String roomID) async {
    final RoomModel? roomData = await FirebaseService.getRoomData(roomID);
    final String userId = SharedPrefService.getId()!;
    return (userId == roomData!.hostId) ? true : false;
  }

  static Future<String> getSecretNumber(String roomID) async {
    final String userID = SharedPrefService.getId()!;

    final players = await FirebaseService.getPeopleRoomData(roomID);

    final String secretNumber = players
        .firstWhere((player) => player.playerModel.firebaseID != userID)
        .secretCode!;
    return secretNumber;
  }

  static Future<AppConfig> getAppConfig() async {
    final appConfig = await FirebaseFirestore.instance
        .collection(FirebaseCollections.appConfig)
        .doc('app')
        .get();

    return AppConfig.fromFirestore(appConfig.data()!);
  }

  static Future<RoomSettingsModel?> getRoomSettings(String roomId) async {
    try {
      final roomSettings = await FirebaseFirestore.instance
          .collection(FirebaseCollections.rooms)
          .doc(roomId)
          .collection(FirebaseCollections.roomSettings)
          .doc(roomId)
          .get();

      final RoomSettingsModel roomSettingsModel =
          RoomSettingsModel.fromFirestore(roomSettings.data()!);
      return roomSettingsModel;
    } catch (e) {
      return null;
    }
  }
}

class FirebaseCollections {
  static const String rooms = "Rooms";
  static const String players = "Players";
  static const String roomPeople = "RoomPeople";
  static const String attempts = "Attempts";
  static const String roomSettings = "RoomSettings";
  static const String appConfig = "Config";
}
