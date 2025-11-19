import 'package:flutter/material.dart';

class Homepagelogo extends StatelessWidget {
  const Homepagelogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Image.asset("assets/images/Logo.jpg"),
      ),
    );
  }
}
