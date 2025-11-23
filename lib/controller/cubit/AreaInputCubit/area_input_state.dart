part of 'area_input_cubit.dart';

@immutable
abstract class AreaInputState {}

class AreaInputInitial extends AreaInputState {}

class AreaInputSelectionChanged extends AreaInputState {
  final bool selected;
  AreaInputSelectionChanged(this.selected);
}

class AreaInputLoading extends AreaInputState {}

class AreaInputSuccess extends AreaInputState {
  final SolarSystemModel solarSystemModel;
  AreaInputSuccess(this.solarSystemModel);
}

class AreaInputFailer extends AreaInputState {}
