import 'package:flutter/material.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomButton.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomChooseSolarType.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomTextFormFeild.dart';

import '../../core/const/TextStyle.dart';
import '../widget/GenralWidget/CustomAppBar.dart';
import '../widget/GenralWidget/ObstaclesOptionSelector.dart';

class AreaInput extends StatefulWidget {
  const AreaInput({super.key});

  @override
  State<AreaInput> createState() => _AreaInputState();
}

class _AreaInputState extends State<AreaInput> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: CustomAppBar(title: "Calculate by Available Area"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Available Area',
                style: AppTextStyle.textStyle26,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter the total available area for installation in square meters.',
                style: AppTextStyle.textStyle16,
              ),
              const SizedBox(height: 32),
              Text('Available Area (m²)', style: AppTextStyle.textStyle17),
              const SizedBox(height: 8),
              Customtextformfeild(
                hintText: "For example: 50",
                suffixText: 'm²',
              ),
              const SizedBox(height: 24),
              Text('Type of Solar Cells', style: AppTextStyle.textStyle17),
              const SizedBox(height: 8),
              CustomChooseSolartype(),
              const SizedBox(height: 32),
              Text(
                'Are there fences or obstacles?',
                style: AppTextStyle.textStyle17,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ObstaclesOptionSelector(
                      title: 'Yes',
                      selected: false,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: ObstaclesOptionSelector(
                      selected: true,
                      title: 'No',
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Spacer(),
              CustomButton(text: "Calculation", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
