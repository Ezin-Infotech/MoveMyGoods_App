import 'package:flutter/material.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/custom_text.dart';
import 'package:mmg/app/utils/common%20widgets/textform.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class BookingTextFieldWidgets extends StatelessWidget {
  final String? labeText;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;

  const BookingTextFieldWidgets(
      {required this.controller,
      required this.labeText,
      required this.hintText,
      this.keyboardType,
      super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizeBoxH(10),
        CustomText(
          text: labeText ?? 'Source',
        ),
        const SizeBoxH(8),
        CommonTextForm(
          controller: controller ?? bookingProvider.sourceController,
          onChanged: (p0) {},
          radius: 4.0,
          fillColor: Colors.transparent,
          enabledBorder: const Color(0xffDBDBDB),
          borderColor: const Color(0xffDBDBDB),
          focusedBorder: const Color(0xffDBDBDB),
          hintText: hintText ?? 'mysore,karnadaka',
          keyboardType: keyboardType ?? TextInputType.text,
          hintTextStyle: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w300, color: const Color(0xff222222)),
          hintTextColor: AppColors.darkGrey,
        ),
      ],
    );
  }
}