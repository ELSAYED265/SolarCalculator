import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solar_calculator_app/core/const/TextStyle.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomAppBar.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomButton.dart';

import '../widget/GenralWidget/ResultInfoCard.dart';
import '../widget/resultArea/CustomButtonResultArea.dart';

class AreaResult extends StatelessWidget {
  const AreaResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: CustomAppBar(title: "Result of Area Calculation"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                ResultInfoCard(
                  icon: FontAwesomeIcons.ruler,
                  title: 'Actual Area',
                  subtitle: '90 m²',
                ),
                ResultInfoCard(
                  icon: Icons.solar_power,
                  title: "Number of Panels",
                  subtitle: '15',
                ),
                ResultInfoCard(
                  icon: Icons.flash_on,
                  title: "Total Plant Capacity",
                  subtitle: '5.4 kW',
                ),
                ResultInfoCard(
                  icon: Icons.monetization_on,
                  title: "Estimated Cost",
                  subtitle: '\$4,860',
                ),
                const SizedBox(height: 20),
                const Text(
                  'These numbers are estimates and may vary based on panel type and other factors.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                Spacer(),
                CustombuttonResultarea(),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Logic for starting a new calculation
                    },
                    child: const Text(
                      'New Calculation',
                      style: TextStyle(
                        color: AppColor.secondColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationThickness: 1.5,
                        decorationColor: AppColor.secondColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//103F1F
