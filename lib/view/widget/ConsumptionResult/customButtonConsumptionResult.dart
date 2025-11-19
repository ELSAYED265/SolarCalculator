import 'package:flutter/material.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';

class CustomButtonConsumptionResult extends StatelessWidget {
  const CustomButtonConsumptionResult({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed:
          onPressed ??
          () {
            // Handle Recalculate action
          },
      style: TextButton.styleFrom(
        foregroundColor: AppColor.secondColor, // لون النص والأيقونة والرِبل
      ),
      icon: const Icon(
        Icons.cached,
        size: 20,
        // ممكن تسيبه بدون لون عشان ياخد foregroundColor من الستيل
      ),
      label: const Text(
        'Recalculate',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          // سيب اللون فاضي عشان ياخد من styleFrom (foregroundColor)
        ),
      ),
    );
  }
}
