import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../../../core/const/appRoute.dart';

part 'area_input_state.dart';

class AreaInputCubit extends Cubit<AreaInputState> {
  AreaInputCubit() : super(AreaInputInitial());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  getResult(BuildContext context) {
    if (formKey.currentState!.validate()) {
      GoRouter.of(context).push(AppRoute.Arearesult);
    }
  }
}
