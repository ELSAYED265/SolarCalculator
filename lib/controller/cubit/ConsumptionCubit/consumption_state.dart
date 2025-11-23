part of 'consumption_cubit.dart';

@immutable
sealed class ConsumptionState {}

final class ConsumptionInitial extends ConsumptionState {}

final class ConsumptionSuccess extends ConsumptionState {
  final SolarSystemModel solarSystemModel;
  ConsumptionSuccess(this.solarSystemModel);
}

final class ConsumptionLoading extends ConsumptionState {}

final class ConsumptionFailer extends ConsumptionState {}
