import 'package:flutter/material.dart';

import '../../../core/const/TextStyle.dart';
import '../../../core/const/appColor.dart';

class ObstaclesOptionSelector extends StatelessWidget {
  const ObstaclesOptionSelector({
    super.key,
    required this.title,
    this.selected = false,
    required this.borderRadius,
    this.onPressed,
  });

  final String title;
  final bool selected;
  final BorderRadius borderRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: selected == true
              ? AppColor.selectionColor
              : AppColor.unselectionColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: Text(
          title,
          style: AppTextStyle.textStyle17.copyWith(
            color: selected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}
