import 'package:flutter/material.dart';

class InfoaboutResult extends StatelessWidget {
  const InfoaboutResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, size: 20),
        const SizedBox(width: 8),
        const Expanded(
          child: Text(
            'Results and costs are preliminary estimates and may vary based on location, panel efficiency, and market prices.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
      ],
    );
  }
}
