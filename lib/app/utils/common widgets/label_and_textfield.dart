import 'package:flutter/material.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/custom_text.dart';
import 'package:mmg/app/utils/common%20widgets/textform.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';

class BookingTextFieldWidgets extends StatelessWidget {
  final String labeText;
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final dynamic Function(String)? onChanged;
  final int? maxLength;
  final String? Function(String?)? validator;
  const BookingTextFieldWidgets(
      {required this.controller,
      required this.labeText,
      required this.hintText,
      this.onChanged,
      this.keyboardType,
      this.maxLength,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizeBoxH(18),
        CustomText(
          text: labeText,
        ),
        const SizeBoxH(8),
        CommonTextForm(
          maxLength: maxLength,
          controller: controller,
          onChanged: onChanged ?? (p0) {},
          validator: validator,
          radius: 4.0,
          fillColor: Colors.transparent,
          enabledBorder: const Color(0xffDBDBDB),
          borderColor: const Color(0xffDBDBDB),
          focusedBorder: const Color(0xffDBDBDB),
          hintText: hintText,
          keyboardType: keyboardType ?? TextInputType.text,
          hintTextStyle: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w300, color: const Color(0xff222222)),
          hintTextColor: AppColors.darkGrey,
        ),
      ],
    );
  }
}
