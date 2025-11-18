import 'package:flutter/material.dart';
import 'package:solar_calculator_app/view/screen/home_page.dart';

void main() {
  runApp(const SolarCalculator());
}

class SolarCalculator extends StatelessWidget {
  const SolarCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'حاسبة الطاقة الشمسية',
      debugShowCheckedModeBanner: false,
      // توجيه النص لليمين ليتناسب مع اللغة العربية
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily:
            'Tajawal', // استخدام خط مناسب (يفترض توفره أو استخدام الخط الافتراضي)
        useMaterial3: true,
      ),
      // إضافة BlocProvider لتهيئة البلوك وجعله متاحاً في الشجرة
      home: HomePage(),
    );
  }
}
