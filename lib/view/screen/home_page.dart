import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_calculator_app/controller/Bloc/AreaInputBloc/area_input_cubit.dart';
import 'package:solar_calculator_app/controller/Bloc/HomePageBloc/home_page_cubit.dart';
import 'package:solar_calculator_app/core/const/TextStyle.dart';
import 'package:solar_calculator_app/core/const/appColor.dart';
import 'package:solar_calculator_app/core/const/appRoute.dart';
import '../widget/GenralWidget/CustomButton.dart';
import '../widget/HomePageWidge/HomePageLogo.dart';
import '../widget/HomePageWidge/HomePageSelectionCard.dart';
import '../widget/HomePageWidge/SnackBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 40,
          bottom: 15,
        ),
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<HomePageCubit>(context);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Homepagelogo(),
                const SizedBox(height: 20),
                Text(
                  "Solar Energy Calculator",
                  style: AppTextStyle.textStyle28,
                ),
                const SizedBox(height: 10),
                Text(
                  "Choose What You Want to Calculate",
                  style: AppTextStyle.textStyle16,
                ),
                const SizedBox(height: 100),

                // كارت 1
                HomePageSelectionCard(
                  isSelected: cubit.selectedIndex == 1,
                  onTap: () {
                    cubit.chooseItem(1);
                  },
                  icon: Icons.bolt_outlined,
                  title: "Calculate Daily Consumption",
                  subtitle: "Enter bill or device usage",
                ),
                const SizedBox(height: 14),

                // كارت 2
                HomePageSelectionCard(
                  isSelected: cubit.selectedIndex == 2,
                  onTap: () {
                    cubit.chooseItem(2);
                  },
                  icon: Icons.grid_on,
                  title: "Calculate the available area",
                  subtitle: "Enter Available space",
                ),

                Spacer(),

                CustomButton(
                  text: "Next",
                  onPressed: () {
                    if (cubit.selectedIndex == null) {
                      showCustomSnackBar(context);
                    } else {
                      if (cubit.direction == 1) {
                        GoRouter.of(context).push(AppRoute.consumptionInput);
                      } else if (cubit.direction == 2) {
                        GoRouter.of(context).push(AppRoute.Areainput);
                      }
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
