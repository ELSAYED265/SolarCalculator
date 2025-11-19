import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_calculator_app/view/screen/ConsumptionInput.dart';
import 'package:solar_calculator_app/view/screen/home_page.dart';

import 'controller/Bloc/home_page_cubit.dart';
import 'core/const/appRoute.dart';

void main() {
  runApp(const SolarCalculator());
}

class SolarCalculator extends StatelessWidget {
  const SolarCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomePageCubit(),
      child: MaterialApp.router(
        routerConfig: AppRoute.router,
        title: 'حاسبة الطاقة الشمسية',
        debugShowCheckedModeBanner: false,
        // توجيه النص لليمين ليتناسب مع اللغة العربية
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
        theme: ThemeData(brightness: Brightness.dark),
      ),
    );
  }
}
