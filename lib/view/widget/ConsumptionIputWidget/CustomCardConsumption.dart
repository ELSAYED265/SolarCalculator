import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_calculator_app/view/widget/ConsumptionIputWidget/CustomChooseSolarTypeForConsum.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomTextFormFeild.dart';

import '../../../controller/cubit/ConsumptionCubit/consumption_cubit.dart';
import '../../../core/const/TextStyle.dart';
import '../../../core/const/appColor.dart';

class CustomCardConsumption extends StatelessWidget {
  const CustomCardConsumption({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConsumptionCubit>();

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
            Customtextformfeild(
              hintText: 'e.g., 25',
              suffixText: 'kWh / day',
              controller: cubit.controller,
            ),
            const SizedBox(height: 30),
            Text('Solar Cell Type', style: AppTextStyle.textStyle17),
            const SizedBox(height: 8),
            CustomChooseSolartypeForConsum(),
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
