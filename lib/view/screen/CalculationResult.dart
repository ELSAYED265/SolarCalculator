import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solar_calculator_app/core/const/TextStyle.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import 'package:solar_calculator_app/view/widget/ConsumptionResult/InfoAboutConsumtionResult.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomAppBar.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomButton.dart';
import '../widget/ConsumptionResult/customButtonConsumptionResult.dart';
import '../widget/GenralWidget/ResultInfoCard.dart';
import '../widget/resultArea/CustomButtonResultArea.dart';

class CalculationResult extends StatelessWidget {
  const CalculationResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: CustomAppBar(title: "Calculation Result"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Your Solar Requirements',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.textStyle20,
                ),
                const SizedBox(height: 16),
                ResultInfoCard(
                  icon: Icons.flash_on,
                  title: 'Required Plant Capacity',
                  subtitle: '5.2 kW',
                ),
                ResultInfoCard(
                  icon: Icons.area_chart,
                  title: "Required Area for Panels",
                  subtitle: '26 m²',
                ),
                ResultInfoCard(
                  icon: Icons.grid_view,
                  title: "Number of Panels Needed",
                  subtitle: '12',
                ),
                ResultInfoCard(
                  icon: Icons.attach_money,
                  title: "Estimated Cost",
                  subtitle: '\$4,860',
                ),
                const SizedBox(height: 20),
                CustombuttonResultarea(),
                const SizedBox(height: 25),
                InfoaboutConsumptionResult(),
                Spacer(),
                CustomButtonConsumptionResult(onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//103F1F
