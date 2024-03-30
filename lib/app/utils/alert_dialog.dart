// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';

class DeleteAlertDialog extends StatelessWidget {
  final void Function() onTapYes;

  final String title;
  final String content;
  final String? buttonLabel;
  // final bool isDarkMode;
  const DeleteAlertDialog({
    required this.onTapYes,
    required this.content,
    required this.title,
    this.buttonLabel,
    // required this.isDarkMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // var brightness = MediaQuery.of(context).platformBrightness;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: AppColors.kLight,
      title: Text(
        title,
        style: context.textTheme.bodyMedium!.copyWith(
          color: AppColors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        content,
        style: context.textTheme.bodyMedium!.copyWith(
          color: AppColors.black,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Cancel'.tr,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.primary,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onTapYes,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                buttonLabel ?? 'Remove'.tr,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.kLight,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
