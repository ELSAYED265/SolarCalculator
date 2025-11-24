import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import 'package:solar_calculator_app/core/const/appRoute.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomButton.dart';
import 'package:solar_calculator_app/view/widget/ConsumptionIputWidget/CustomChooseSolarTypeForConsum.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomTextFormFeild.dart';

import '../../controller/cubit/AreaInputCubit/area_input_cubit.dart';
import '../../core/const/TextStyle.dart';
import '../widget/GenralWidget/CustomAppBar.dart';
import '../widget/GenralWidget/ObstaclesOptionSelector.dart';
import '../widget/resultArea/CustomChooseSolartypeForArea.dart';

class AreaInput extends StatelessWidget {
  const AreaInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: CustomAppBar(title: "Calculate by Available Area"),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
            text: "Calculation",
            onPressed: () {
              context.read<AreaInputCubit>().getResult(context);
            },
          ),
        ),
        body: Form(
          key: context.read<AreaInputCubit>().formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: BlocConsumer<AreaInputCubit, AreaInputState>(
              listener: (context, state) {
                if (state is AreaInputSuccess) {
                  GoRouter.of(context).push(AppRoute.Arearesult);
                }

                if (state is AreaInputFailer) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error occurred')),
                  );
                }
              },
              builder: (BuildContext context, AreaInputState state) {
                final isLoading = state is AreaInputLoading;
                return isLoading == true
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Enter Available Area',
                            style: AppTextStyle.textStyle26,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Enter the total available area for installation in square meters.',
                            style: AppTextStyle.textStyle16,
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Available Area (m²)',
                            style: AppTextStyle.textStyle17,
                          ),
                          const SizedBox(height: 8),
                          Customtextformfeild(
                            controller: context
                                .read<AreaInputCubit>()
                                .Controller,
                            hintText: "For example: 50",
                            suffixText: 'm²',
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Type of Solar Cells',
                            style: AppTextStyle.textStyle17,
                          ),
                          const SizedBox(height: 8),
                          CustomChooseSolartypeForArea(),
                          const SizedBox(height: 32),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
