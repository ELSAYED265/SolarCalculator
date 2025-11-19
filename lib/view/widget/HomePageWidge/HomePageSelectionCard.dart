import 'package:flutter/material.dart';

import '../../../core/const/TextStyle.dart';
import '../../../core/const/appColor.dart';

class HomePageSelectionCard extends StatelessWidget {
  const HomePageSelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // موضع الظل
          ),
        ],
        color: AppColor.DarkColor, // لون خلفية البطاقة
        borderRadius: BorderRadius.circular(10),
        border: isSelected == true
            ? Border.all(color: AppColor.secondColor, width: 1)
            : Border(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: AppColor.secondColor),
              const SizedBox(height: 9),
              Text(title, style: AppTextStyle.textStyle17),
              const SizedBox(height: 5),
              Text(subtitle, style: AppTextStyle.textStyle14),
            ],
          ),
        ],
      ),
    );
  }
}
