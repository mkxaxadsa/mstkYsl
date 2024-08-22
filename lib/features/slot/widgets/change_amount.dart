// import 'package:flutter/cupertino.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../core/config/app_colors.dart';
//
// class ChangeAmount extends StatelessWidget {
//   const ChangeAmount({
//     super.key,
//     required this.amount,
//     required this.onPressed,
//   });
//
//   final int amount;
//   final void Function(bool) onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Text(
//           'Total Coins',
//           style: TextStyle(
//             color: AppColors.secondary,
//             fontSize: 20,
//             fontFamily: Fonts.inter,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             CupertinoButton(
//               onPressed: () {
//                 onPressed(false);
//               },
//               padding: EdgeInsets.zero,
//               child: Container(
//                 height: 48,
//                 width: 48,
//                 decoration: BoxDecoration(
//                   color: AppColors.secondary,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     width: 2,
//                     color: AppColors.main,
//                   ),
//                 ),
//                 child: Center(
//                   child: SvgPicture.asset(
//                     'assets/back.svg',
//                     color: AppColors.main,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               height: 48,
//               width: 56,
//               decoration: BoxDecoration(
//                 color: AppColors.main,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   width: 2,
//                   color: AppColors.secondary,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   amount.toString(),
//                   style: const TextStyle(
//                     color: AppColors.secondary,
//                     fontSize: 20,
//                     fontFamily: Fonts.inter,
//                   ),
//                 ),
//               ),
//             ),
//             CupertinoButton(
//               onPressed: () {
//                 onPressed(true);
//               },
//               padding: EdgeInsets.zero,
//               child: Container(
//                 height: 48,
//                 width: 48,
//                 decoration: BoxDecoration(
//                   color: AppColors.secondary,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     width: 2,
//                     color: AppColors.main,
//                   ),
//                 ),
//                 child: Center(
//                   child: SvgPicture.asset(
//                     'assets/back2.svg',
//                     color: AppColors.main,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
