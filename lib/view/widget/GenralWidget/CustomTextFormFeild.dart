import 'package:flutter/material.dart';

import '../../../core/const/appColor.dart';

class Customtextformfeild extends StatelessWidget {
  const Customtextformfeild({
    super.key,
    required this.hintText,
    required this.suffixText,
  });
  final String hintText;
  final String suffixText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF2E4E30), // خلفية الحقل
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white38),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixText: suffixText, // النص الثابت على اليمين
        suffixStyle: TextStyle(color: Colors.white54, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),
      ),
    );
  }
}
