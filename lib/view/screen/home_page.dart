import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_calculator_app/core/const/TextStyle.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import 'package:solar_calculator_app/core/const/appRoute.dart';
import 'package:solar_calculator_app/view/widget/HomePageWidge/HomePageLogo.dart';

import '../widget/GenralWidget/CustomButton.dart';
import '../widget/HomePageWidge/HomePageSelectionCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 40,
          bottom: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Homepagelogo(),
            const SizedBox(height: 20),
            Text("Solar Energy Calculator", style: AppTextStyle.textStyle28),
            const SizedBox(height: 10),
            Text(
              "Choose Whate You Want to Calculate",
              style: AppTextStyle.textStyle16,
            ),
            const SizedBox(height: 100),
            HomePageSelectionCard(
              isSelected: true,
              icon: Icons.bolt_outlined,
              title: "Calculate Daily Consumption",
              subtitle: "Enter bill or device usage",
            ),
            const SizedBox(height: 14),
            HomePageSelectionCard(
              isSelected: false,
              icon: Icons.grid_on,
              title: "Calculate the available area",
              subtitle: " Enter Available space",
            ),
            Spacer(),
            CustomButton(
              text: "Next",
              onPressed: () {
                context.push(AppRoute.consumptionInput);
              },
            ),
          ],
        ),
      ),
    );
  }
}
