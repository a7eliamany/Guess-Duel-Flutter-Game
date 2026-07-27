import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/Join%20Room/join_room_cubit.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';
import 'package:guess_duel/screens/rooms/widgets/room_card.dart';

class RoomsList extends StatelessWidget {
  final List<RoomModel> rooms;
  const RoomsList({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final RoomModel room = rooms[index];

        return RoomCard(
          roomModel: room,
          onJoin: () async {
            await context.read<JoinRoomCubit>().joinRoom(room.roomId);
          },
        );
      },
    );
  }
}
