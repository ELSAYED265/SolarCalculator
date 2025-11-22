import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import 'package:solar_calculator_app/core/const/appRoute.dart';
import 'package:solar_calculator_app/view/widget/ConsumptionIputWidget/CustomCardConsumption.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomAppBar.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomButton.dart';

import '../../controller/Bloc/ConsumptionBloc/consumption_cubit.dart';
import '../../core/const/TextStyle.dart';

class ConsumptionInput extends StatefulWidget {
  const ConsumptionInput({super.key});

  @override
  State<ConsumptionInput> createState() => _ConsumptionInputState();
}

class _ConsumptionInputState extends State<ConsumptionInput> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: true, // يتأثر بالكيبورد
        backgroundColor: AppColor.primaryColor,
        appBar: CustomAppBar(title: "Energy Consumption"),
        body: Form(
          key: context.read<ConsumptionCubit>().formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SingleChildScrollView(
              // المسافة اللي تحت تتأقلم مع ارتفاع الكيبورد
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter your average daily usage',
                    style: AppTextStyle.textStyle26,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You can usually find this on your monthly electricity bill.',
                    style: AppTextStyle.textStyle16,
                  ),
                  const SizedBox(height: 26),

                  // الكارد اللي فيه TextFormField
                  const CustomCardConsumption(),

                  const SizedBox(height: 230),

                  CustomButton(
                    text: " Calculation",
                    onPressed: () {
                      context.read<ConsumptionCubit>().getResult(context);
                    },
                  ),
                  const SizedBox(height: 12),

                  Text(
                    'Don\'t know your consumption? Calculate with roof area.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColor.brightColor, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
