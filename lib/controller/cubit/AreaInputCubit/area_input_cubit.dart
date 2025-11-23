import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../../../Model/SolarSystemModel.dart';
import '../../../core/const/appRoute.dart';

part 'area_input_state.dart';

class AreaInputCubit extends Cubit<AreaInputState> {
  AreaInputCubit() : super(AreaInputInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //SolarSystemModel solarSystemModel;
  getResult(BuildContext context) {
    if (formKey.currentState!.validate()) {
      try {
        emit(AreaInputLoading());
      } catch (e) {}
      // GoRouter.of(context).push(AppRoute.Arearesult);
    }
  }
}
