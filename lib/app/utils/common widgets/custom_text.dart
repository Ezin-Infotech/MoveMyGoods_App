import 'package:flutter/material.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/extensions.dart';

class CustomText extends StatelessWidget {
  final String? text;
  const CustomText({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: context.textTheme.displaySmall!.copyWith(
          fontFamily: 'Inter',
          color: AppColors.primary,
          fontSize: 18,
          fontWeight: FontWeight.w500),
    );
  }
}
