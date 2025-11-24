import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_calculator_app/controller/cubit/ConsumptionCubit/consumption_cubit.dart';
import 'package:solar_calculator_app/core/const/TextStyle.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/InfoAboutResult.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomAppBar.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomButton.dart';
import '../widget/ConsumptionResult/customButtonConsumptionResult.dart';
import '../widget/GenralWidget/MonoTypeInfo.dart';
import '../widget/GenralWidget/ResultInfoCard.dart';
import '../widget/resultArea/CustomButtonResultArea.dart';

class ConsumptionResult extends StatelessWidget {
  const ConsumptionResult({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ConsumptionCubit>().solarSystemModel!;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: CustomAppBar(title: "Calculation Result"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Your Solar Requirements',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.textStyle20,
                ),
                const SizedBox(height: 16),
                ResultInfoCard(
                  icon: Icons.flash_on,
                  title: 'Required Plant Capacity',
                  subtitle:
                      '${model.actualSystemCapacityKwp.toStringAsFixed(3)}' +
                      'KWp',
                ),
                ResultInfoCard(
                  icon: Icons.area_chart,
                  title: "Required Area for Panels",
                  subtitle: '${model.requiredArea.toStringAsFixed(2)}' + 'm²',
                ),
                ResultInfoCard(
                  icon: Icons.grid_view,
                  title: "Number of Panels Needed",
                  subtitle: '${model.numberOfPanels}',
                ),
                ResultInfoCard(
                  icon: Icons.attach_money,
                  title: "Estimated Cost",
                  subtitle: '\$${model.initialCost.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 20),
                CustombuttonResultarea(
                  onPressed: () {
                    context
                        .read<ConsumptionCubit>()
                        .generateConsumptionResultPdf();
                  },
                ),
                const SizedBox(height: 12),
                MonoTypeInfo(),
                const SizedBox(height: 12),
                InfoaboutResult(),
                Spacer(),
                CustomButtonConsumptionResult(
                  onPressed: () {
                    context.read<ConsumptionCubit>().Recalculate(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//103F1F
