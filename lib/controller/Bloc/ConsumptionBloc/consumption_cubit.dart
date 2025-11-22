import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../../../core/const/appRoute.dart';

part 'consumption_state.dart';

class ConsumptionCubit extends Cubit<ConsumptionState> {
  ConsumptionCubit() : super(ConsumptionInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  getResult(BuildContext context) {
    if (formKey.currentState!.validate()) {
      GoRouter.of(context).push(AppRoute.consumptionResult);
    }
  }
}
