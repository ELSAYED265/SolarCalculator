part of 'area_input_cubit.dart';

@immutable
sealed class AreaInputState {}

final class AreaInputInitial extends AreaInputState {}

final class AreaInputSuccess extends AreaInputState {}

final class AreaInputLoading extends AreaInputState {}

final class AreaInputFailer extends AreaInputState {}
