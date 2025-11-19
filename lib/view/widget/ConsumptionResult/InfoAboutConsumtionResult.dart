import 'package:flutter/material.dart';

class InfoaboutConsumptionResult extends StatelessWidget {
  const InfoaboutConsumptionResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, size: 20, color: Color(0xFF0A531E)),
        const SizedBox(width: 8),
        const Expanded(
          child: Text(
            'Results and costs are preliminary estimates and may vary based on location, panel efficiency, and market prices.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF0A531E),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
