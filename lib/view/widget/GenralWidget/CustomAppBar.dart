import 'package:flutter/material.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import '../../../core/const/TextStyle.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.DarkColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      centerTitle: true,
      title: Text(title, style: AppTextStyle.textStyle20),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
