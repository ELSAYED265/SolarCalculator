import 'package:flutter/material.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import 'package:solar_calculator_app/view/widget/ConsumptionIputWidget/CustomCardConsumption.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomAppBar.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomButton.dart';

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
        backgroundColor: AppColor.primaryColor,
        appBar: CustomAppBar(title: "Energy Consumption"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const Text(
                'Enter your average daily usage',
                style: AppTextStyle.textStyle26,
              ),
              const SizedBox(height: 8),
              // الوصف
              Text(
                'You can usually find this on your monthly electricity bill.',
                style: AppTextStyle.textStyle16,
              ),
              const SizedBox(height: 26),
              CustomCardConsumption(),
              const Spacer(),
              CustomButton(text: " Calculation", onPressed: () {}),
              const SizedBox(height: 12),
              Text(
                'Don\'t know your consumption? Calculate with roof area.',
                style: TextStyle(color: AppColor.brightColor, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
