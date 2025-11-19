part of 'home_page_cubit.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {
  final bool isSelected;
  HomePageInitial({this.isSelected = false});
}

final class HomePageUnChange extends HomePageState {
  HomePageUnChange();
}

final class HomePageChange extends HomePageState {
  final int isSelected;
  HomePageChange(this.isSelected);
}
