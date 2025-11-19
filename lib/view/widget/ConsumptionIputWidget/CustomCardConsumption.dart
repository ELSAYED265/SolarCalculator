import 'package:flutter/material.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomChooseSolarType.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomTextFormFeild.dart';

import '../../../core/const/TextStyle.dart';
import '../../../core/const/appColor.dart';

class CustomCardConsumption extends StatefulWidget {
  const CustomCardConsumption({super.key});

  @override
  State<CustomCardConsumption> createState() => _CustomCardConsumptionState();
}

class _CustomCardConsumptionState extends State<CustomCardConsumption> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppColor.DarkColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Consumption', style: AppTextStyle.textStyle17),
            const SizedBox(height: 8),
            Customtextformfeild(hintText: 'e.g., 25', suffixText: 'kWh / day'),
            const SizedBox(height: 30),
            Text('Solar Cell Type', style: AppTextStyle.textStyle17),

            const SizedBox(height: 8),
            CustomChooseSolartype(),
            // الوصف أسفل القائمة المنسدلة
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Efficiency and cost vary by type.',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
