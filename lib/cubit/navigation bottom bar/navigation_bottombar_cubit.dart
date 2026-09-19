import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBottombarCubit extends Cubit<int> {
  NavigationBottombarCubit() : super(0);
  int get currentIndex => state;
  void changePage(int index) {
    emit(index);
  }
}
