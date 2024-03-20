// import 'package:flutter/material.dart';
// import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
// import 'package:mmg/app/utils/app%20style/colors.dart';
// import 'package:mmg/app/utils/extensions.dart';
// import 'package:provider/provider.dart';

// class DropdownInsideTextFormField extends StatefulWidget {
//   final bool? isGoodsWeight;
//   const DropdownInsideTextFormField({this.isGoodsWeight, super.key});

//   @override
//   _DropdownInsideTextFormFieldState createState() =>
//       _DropdownInsideTextFormFieldState();
// }

// class _DropdownInsideTextFormFieldState
//     extends State<DropdownInsideTextFormField> {
//   @override
//   Widget build(BuildContext context) {
//     final bookingProvider =
//         Provider.of<BookingProvider>(context, listen: false);
//     return Container(
//       padding: const EdgeInsets.only(left: 10),
//       height: 50,
//       width: context.width,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4),
//           border: Border.all(color: Colors.grey.withOpacity(0.4)),
//           color: AppColors.bgColor),
//       child: DropdownButton<String>(
//         disabledHint: const Text('selected'),
//         underline: const SizedBox(),
//         value: bookingProvider.selectedOption,
//         onChanged: (value) {},
//         icon: const Padding(
//           padding: EdgeInsets.only(left: 15, right: 7),
//           child: Icon(Icons.keyboard_arrow_down,
//               size: 28, color: Color(0xffA8A4B0)),
//         ),
//         style: context.textTheme.bodyLarge!.copyWith(
//             fontSize: 16,
//             color: const Color(0xffA8A4B0),
//             fontWeight: FontWeight.w400),
//         isExpanded: true,
//         iconEnabledColor: Colors.amber,
//         dropdownColor: AppColors.bgColor,
//         items: bookingProvider.lists.map<DropdownMenuItem<String>>(
//           (String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           },
//         ).toList(),
//       ),
//     );
//   }
// }
