import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../../../Model/SolarSystemModel.dart';
import '../../../core/const/appRoute.dart';
import '../../../core/const/factory.dart';

part 'area_input_state.dart';

class AreaInputCubit extends Cubit<AreaInputState> {
  AreaInputCubit() : super(AreaInputInitial()) {
    Controller = TextEditingController();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool selected = false; // false = No obstacles, true = Yes obstacles
  late TextEditingController Controller;
  late SolarSystemModel solarSystemModel;

  final double panelPowerWp = 380;
  final double panelAreaM2 = 1.95;
  final double costPerWp = 0.8;

  void changeSelection(bool value) {
    selected = value;
    print('selected = $selected');
    emit(AreaInputSelectionChanged(selected));
  }

  void getResult(BuildContext context) {
    if (formKey.currentState!.validate()) {
      try {
        emit(AreaInputLoading());

        double area = double.parse(Controller.text);

        // لو في عوائق (Yes)
        if (selected == true) {
          area = area * 0.95; // تقليل 5% بسبب العوائق
        }

        final actualSystemCapacityKwp = (area / 5) * 0.555;
        final numberOfPanels = (area / 5).ceil();
        final initialCost = actualSystemCapacityKwp * 1100;

        solarSystemModel = SolarSystemModel(
          actualSystemCapacityKwp: actualSystemCapacityKwp,
          numberOfPanels: numberOfPanels,
          requiredArea: area,
          initialCost: initialCost,
        );
        emit(AreaInputSuccess(solarSystemModel));
      } catch (e) {
        emit(AreaInputFailer());
      }
    }
  }

  @override
  Future<void> close() {
    Controller.dispose();
    return super.close();
  }
}
