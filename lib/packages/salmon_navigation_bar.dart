import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/navigation%20bottom%20bar/navigation_bottombar_cubit.dart';
import 'package:remixicon/remixicon.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SalmonNavigationBar extends StatelessWidget {
  final PageController pageController;
  const SalmonNavigationBar({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<NavigationBottombarCubit, int>(
        builder: (context, state) {
          return SalomonBottomBar(
            currentIndex: state,
            onTap: (index) {
              pageController.jumpToPage(index);
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(RemixIcons.home_line),
                title: const Text("Home"),
                selectedColor: Colors.purple,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: const Icon(RemixIcons.gamepad_line),
                title: const Text("Lobby"),
                selectedColor: Colors.pink,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: const Icon(RemixIcons.history_line),
                title: const Text("History"),
                selectedColor: Colors.orange,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: const Icon(RemixIcons.user_line),
                title: const Text("Profile"),
                selectedColor: Colors.grey,
              ),
            ],
          );
        },
      ),
    );
  }
}
