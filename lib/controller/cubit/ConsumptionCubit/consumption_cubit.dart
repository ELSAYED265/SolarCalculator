import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:solar_calculator_app/Model/SolarSystemModel.dart';

import '../../../core/const/appRoute.dart';
import '../../../core/const/factory.dart';

part 'consumption_state.dart';

class ConsumptionCubit extends Cubit<ConsumptionState> {
  ConsumptionCubit() : super(ConsumptionInitial()) {
    controller = TextEditingController();
  }
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController controller;
  late SolarSystemModel solarSystemModel;
  final double panelPowerWp = 380;
  final double panelAreaM2 = 1.95;
  final double costPerWp = 0.8;
  getResult(BuildContext context) {
    if (formKey.currentState!.validate()) {
      try {
        emit(ConsumptionLoading());
        final consumption = double.tryParse(controller.text);
        if (consumption != null) {
          final actualSystemCapacityKwp =
              (consumption * Factory.systemLossFactor) / Factory.sunHoursPerDay;

          final numberOfPanels =
              (actualSystemCapacityKwp *
                      Factory.capacityToPanelRatio /
                      (panelPowerWp / 1000))
                  .ceil();

          final requiredArea = (numberOfPanels * Factory.areaPerPanelMultiplier)
              .toDouble();

          final initialCost =
              (actualSystemCapacityKwp * Factory.initialCostMultiplier) *
              costPerWp;

          solarSystemModel = SolarSystemModel(
            actualSystemCapacityKwp: actualSystemCapacityKwp,
            numberOfPanels: numberOfPanels,
            requiredArea: requiredArea,
            initialCost: initialCost,
          );
          Future.delayed(const Duration(seconds: 10), () {
            emit(ConsumptionSuccess(solarSystemModel));
          });
        }
      } catch (e) {
        emit(ConsumptionFailer());
      }
    }
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
