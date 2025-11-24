import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_calculator_app/controller/cubit/AreaInputCubit/area_input_cubit.dart';
import 'package:solar_calculator_app/controller/cubit/ConsumptionCubit/consumption_cubit.dart';

class CustomChooseSolartypeForArea extends StatelessWidget {
  CustomChooseSolartypeForArea({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AreaInputCubit, AreaInputState>(
      builder: (context, state) {
        final cubit = context.read<AreaInputCubit>();
        return Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF2E4E30), // خلفية الحقل
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: cubit.selectedSolarType,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              dropdownColor: const Color(0xFF2E4E30),
              style: const TextStyle(fontSize: 16),

              onChanged: (String? newValue) {
                if (newValue != null) {
                  cubit.changeSolarType(newValue);
                }
              },

              items: cubit.solarCellTypes.map<DropdownMenuItem<String>>((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
