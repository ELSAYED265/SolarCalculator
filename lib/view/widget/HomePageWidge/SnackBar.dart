import 'package:flutter/material.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';

void showCustomSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
        'Please select an option to proceed.',
        style: TextStyle(
          color: AppColor.secondColor, // نص فاتح
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColor.primaryColor, // خلفية داكنة
      behavior: SnackBarBehavior.floating, // يكون ظاهر بشكل floating
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    ),
  );
}
