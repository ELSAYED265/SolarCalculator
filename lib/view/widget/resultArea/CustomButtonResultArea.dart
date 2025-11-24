import 'package:flutter/material.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';

class CustombuttonResultarea extends StatelessWidget {
  const CustombuttonResultarea({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.secondColor,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      icon: const Icon(
        Icons.picture_as_pdf,
        color: AppColor.primaryColor,
        size: 24,
      ),
      label: const Text(
        'Generate PDF Report',
        style: TextStyle(
          color: AppColor.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
