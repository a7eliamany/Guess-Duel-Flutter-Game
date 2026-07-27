import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/cubit/navigation%20bottom%20bar/navigation_bottombar_cubit.dart';
import 'package:guess_duel/screens/History%20screen/history_screen.dart';
import 'package:guess_duel/screens/home/homepage.dart';
import 'package:guess_duel/packages/salmon_navigation_bar.dart';
import 'package:guess_duel/screens/rooms/rooms_screen.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  late PageController controller;
  @override
  void initState() {
    controller = PageController();
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
        children: const [Homepage(), RoomsScreen(), HistoryScreen()],
      ),
      bottomNavigationBar: SalmonNavigationBar(pageController: controller),
    );
  }
}
