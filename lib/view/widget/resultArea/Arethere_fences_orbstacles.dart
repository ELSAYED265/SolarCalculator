// Text(
//   'Are there fences or obstacles?',
//   style: AppTextStyle.textStyle17,
// ),
// const SizedBox(height: 8),
// BlocBuilder<AreaInputCubit, AreaInputState>(
//   builder: (context, state) {
//     final cubit = context.read<AreaInputCubit>();
//     return Row(
//       children: [
//         Expanded(
//           child: ObstaclesOptionSelector(
//             title: 'Yes',
//             selected: cubit.selected == true,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(12),
//               bottomLeft: Radius.circular(12),
//             ),
//             onPressed: () {
//               context
//                   .read<AreaInputCubit>()
//                   .changeSelection(true);
//             },
//           ),
//         ),
//         // NO = لا يوجد عوائق
//         Expanded(
//           child: ObstaclesOptionSelector(
//             title: 'No',
//             selected: cubit.selected == false,
//             borderRadius: const BorderRadius.only(
//               topRight: Radius.circular(12),
//               bottomRight: Radius.circular(12),
//             ),
//             onPressed: () {
//               context
//                   .read<AreaInputCubit>()
//                   .changeSelection(false);
//             },
//           ),
//         ),
//       ],
//     );
//   },
// ),
// const SizedBox(height: 250),
