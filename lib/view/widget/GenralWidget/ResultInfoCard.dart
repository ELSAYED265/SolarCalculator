import 'package:flutter/material.dart';

import '../../../core/const/TextStyle.dart';
import '../../../core/const/appColor.dart';

class ResultInfoCard extends StatelessWidget {
  const ResultInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: Color(0xFF102B18),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0XFF103F1F),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(right: 16),
            child: Center(
              child: Icon(icon, size: 30, color: AppColor.secondColor),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Color(0xFF0A531E), fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: AppTextStyle.textStyle20.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
