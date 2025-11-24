import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import 'package:solar_calculator_app/core/const/appRoute.dart';
import 'package:solar_calculator_app/view/widget/ConsumptionIputWidget/CustomCardConsumption.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomAppBar.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomButton.dart';
import '../../controller/cubit/ConsumptionCubit/consumption_cubit.dart';
import '../../core/const/TextStyle.dart';

class ConsumptionInput extends StatelessWidget {
  const ConsumptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocConsumer<ConsumptionCubit, ConsumptionState>(
        listener: (context, state) {
          if (state is ConsumptionSuccess) {
            GoRouter.of(context).push(AppRoute.consumptionResult);
          }

          if (state is ConsumptionFailer) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Error occurred')));
          }
        },
        builder: (context, state) {
          final isLoading = state is ConsumptionLoading;

          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColor.primaryColor,
            appBar: CustomAppBar(title: "Energy Consumption"),

            // --------------------  BOTTOM NAVIGATION BAR  --------------------
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColor.brightColor,
                            ),
                          )
                        : CustomButton(
                            text: "Calculation",
                            onPressed: () {
                              context.read<ConsumptionCubit>().getResult(
                                context,
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Don\'t know your consumption? Calculate with roof area.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColor.brightColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            // -----------------------------------------------------------------
            body: Form(
              key: context.read<ConsumptionCubit>().formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter your average daily usage',
                        style: AppTextStyle.textStyle26,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You can usually find this on your monthly electricity bill.',
                        style: AppTextStyle.textStyle16,
                      ),
                      const SizedBox(height: 26),
                      const CustomCardConsumption(),
                      const SizedBox(height: 260), // مساحة احتياطية
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
