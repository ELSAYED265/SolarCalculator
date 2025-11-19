import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  int? selectedIndex; // 1 أو 2
  int? direction; // 1 أو 2 للاستخدام لاحقًا في التنقل

  HomePageCubit() : super(HomePageInitial());

  void chooseItem(int index) {
    selectedIndex = index;
    direction = index;
    emit(HomePageChange(selectedIndex!));
  }
}
