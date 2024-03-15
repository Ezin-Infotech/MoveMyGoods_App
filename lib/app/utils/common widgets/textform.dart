import 'package:flutter/material.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/extensions.dart';

class CommonTextForm extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController controller;
  final bool? obscureText;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? radius;
  final Color? fillColor;
  final Function()? onTap;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final double? width;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final Color? enabledBorder;
  final Color? borderColor;
  final Color? focusedBorder;
  final TextStyle? hintTextStyle;
  final Color? hintTextColor;
  final int? maxLength;
  const CommonTextForm({
    super.key,
    required this.onChanged,
    required this.controller,
    this.hintText,
    this.suffixIcon,
    this.readOnly,
    this.onTap,
    this.prefixIcon,
    this.obscureText,
    this.validator,
    this.labelText,
    this.width,
    this.fillColor,
    this.radius,
    this.labelStyle,
    this.contentPadding,
    this.keyboardType,
    this.enabledBorder,
    this.borderColor,
    this.focusedBorder,
    this.hintTextStyle,
    this.hintTextColor,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      textInputAction: TextInputAction.go,
      onTap: onTap,
      readOnly: readOnly ?? false,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.name,
      cursorColor: Colors.black,
      obscureText: obscureText ?? false,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: context.textTheme.bodyLarge!
          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
      validator: validator,
      decoration: InputDecoration(
        contentPadding: contentPadding ?? const EdgeInsets.all(8),
        label: Text(
          labelText ?? '',
          style:
              labelStyle ?? const TextStyle(color: Colors.black, fontSize: 16),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusColor: Colors.grey,
        fillColor: fillColor ?? Colors.grey,
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon ?? const SizedBox.shrink(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: enabledBorder ?? Colors.grey.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(radius ?? 20)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(radius ?? 20)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(radius ?? 10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedBorder ?? Colors.transparent, width: width ?? 1),
            borderRadius: BorderRadius.circular(radius ?? 20)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? AppColors.primary),
            borderRadius: BorderRadius.circular(radius ?? 10)),
        hintText: hintText,
        hintStyle: hintTextStyle ??
            context.textTheme.bodyLarge!.copyWith(
                fontSize: 16,
                color: hintTextColor ?? const Color(0xff888888),
                fontWeight: FontWeight.w400),
      ),
      onChanged: onChanged,
    );
  }
}
