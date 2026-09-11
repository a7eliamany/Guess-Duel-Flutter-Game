import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/navigation%20bottom%20bar/navigation_bottombar_cubit.dart';
import 'package:guess_duel/screens/History%20screen/history_screen.dart';
import 'package:guess_duel/screens/home/homepage.dart';
import 'package:guess_duel/packages/salmon_navigation_bar.dart';
import 'package:guess_duel/screens/profile/profile_screen.dart';
import 'package:guess_duel/screens/rooms/rooms_screen.dart';

class Pages extends StatefulWidget {
  final int? index;
  const Pages({super.key, this.index});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  late PageController controller;
  @override
  void initState() {
    controller = PageController(initialPage: widget.index ?? 0);
    context.read<NavigationBottombarCubit>().changePage(widget.index ?? 0);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (val) {
          context.read<NavigationBottombarCubit>().changePage(val);
        },
        children: const [
          Homepage(),
          RoomsScreen(),
          HistoryScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: SalmonNavigationBar(pageController: controller),
    );
  }
}
