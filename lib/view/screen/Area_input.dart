import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import 'package:solar_calculator_app/core/const/appRoute.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomButton.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomChooseSolarType.dart';
import 'package:solar_calculator_app/view/widget/GenralWidget/CustomTextFormFeild.dart';

import '../../controller/cubit/AreaInputCubit/area_input_cubit.dart';
import '../../core/const/TextStyle.dart';
import '../widget/GenralWidget/CustomAppBar.dart';
import '../widget/GenralWidget/ObstaclesOptionSelector.dart';

class AreaInput extends StatefulWidget {
  const AreaInput({super.key});

  @override
  State<AreaInput> createState() => _AreaInputState();
}

class _AreaInputState extends State<AreaInput> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: CustomAppBar(title: "Calculate by Available Area"),
        body: SingleChildScrollView(
          child: Form(
            key: context.read<AreaInputCubit>().formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: BlocListener<AreaInputCubit, AreaInputState>(
                listener: (context, state) {
                  if (state is AreaInputLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.brightColor,
                          ),
                        ),
                      ),
                    );
                  } else {
                    if (state is AreaInputSuccess) {
                      GoRouter.of(context).push(AppRoute.Arearesult);
                    }

                    if (state is AreaInputFailer) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error occurred')),
                      );
                    }
                  }
                },
                child: Column(
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
                      controller: context.read<AreaInputCubit>().Controller,
                      hintText: "For example: 50",
                      suffixText: 'm²',
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Type of Solar Cells',
                      style: AppTextStyle.textStyle17,
                    ),
                    const SizedBox(height: 8),
                    const CustomChooseSolartype(),
                    const SizedBox(height: 32),
                    Text(
                      'Are there fences or obstacles?',
                      style: AppTextStyle.textStyle17,
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<AreaInputCubit, AreaInputState>(
                      builder: (context, state) {
                        final cubit = context.read<AreaInputCubit>();
                        return Row(
                          children: [
                            Expanded(
                              child: ObstaclesOptionSelector(
                                title: 'Yes',
                                selected: cubit.selected == true,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                                onPressed: () {
                                  context
                                      .read<AreaInputCubit>()
                                      .changeSelection(true);
                                },
                              ),
                            ),
                            // NO = لا يوجد عوائق
                            Expanded(
                              child: ObstaclesOptionSelector(
                                title: 'No',
                                selected: cubit.selected == false,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                onPressed: () {
                                  context
                                      .read<AreaInputCubit>()
                                      .changeSelection(false);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 250),
                    CustomButton(
                      text: "Calculation",
                      onPressed: () {
                        context.read<AreaInputCubit>().getResult(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
