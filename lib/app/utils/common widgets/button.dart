import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';

class ButtonWidgets extends StatelessWidget {
  final Function()? onPressed;
  final Color? bgColor;
  final Color? textColor;
  final double? textSize;
  final double? butttonRadius;
  final String? buttonText;
  final FontWeight? textWeight;
  final double? width;
  final double? height;
  const ButtonWidgets(
      {required this.onPressed,
      this.bgColor,
      this.textColor,
      this.textSize,
      this.butttonRadius,
      this.buttonText,
      this.textWeight,
      this.width,
      this.height,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 202,
      height: height ?? 42,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? AppColors.primary,

          // side: BorderSide(color: Colors.yellow, width: 5),
          // textStyle: TextStyle(
          //     color: textColor ?? const Color(0xffFFFFFF),
          //     fontSize: textSize ?? 16,
          //     fontStyle: FontStyle.normal,
          //     fontWeight: textWeight ?? FontWeight.w500,
          //     fontFamily: 'Poppins'),

          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(butttonRadius ?? 30))),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText ?? 'Book Now'.tr,
          style: TextStyle(
              color: textColor ?? const Color(0xffFFFFFF),
              fontSize: textSize ?? 16,
              fontStyle: FontStyle.normal,
              fontWeight: textWeight ?? FontWeight.w500,
              fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}
