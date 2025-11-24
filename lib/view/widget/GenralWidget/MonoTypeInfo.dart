import 'package:flutter/material.dart';

class MonoTypeInfo extends StatelessWidget {
  const MonoTypeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.solar_power, size: 20, color: Colors.white70), // ← لون جديد
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'All calculations are based on N-type mono-crystalline (550–580 W each).',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70, // ← نفس اللون الجديد
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
