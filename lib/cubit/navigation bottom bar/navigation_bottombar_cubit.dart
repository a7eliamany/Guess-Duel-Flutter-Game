import 'package:hydrated_bloc/hydrated_bloc.dart';

class NavigationBottombarCubit extends Cubit<int> {
  NavigationBottombarCubit() : super(0);
  int get currentIndex => state;
  void changePage(int index) {
    emit(index);
  }
}
