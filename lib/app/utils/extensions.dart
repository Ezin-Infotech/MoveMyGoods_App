import 'package:flutter/material.dart';
import 'package:get/get.dart';

/* RESPONSIVE SIZE */
extension MediaQuerySize on BuildContext {
  Size getSize() => MediaQuery.of(this).size;
}

extension PercentSized on num {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
}

extension ResponsiveText on num {
  double get sp => Get.width / 100 * (this / 3);
  double get tp => (this * (Get.width / 3) / 100);
  double get px => (Get.width - (Get.width - this));
}

/* RESPONSIVE SIZE */
extension $BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;

  double get topPadding => mediaQuery.padding.top;

  double get bottomPadding => mediaQuery.padding.bottom;

  double get topInset => mediaQuery.viewInsets.top;

  double get bottomInset => mediaQuery.viewInsets.bottom;

  bool get iskeypad => mediaQuery.viewInsets.bottom != 0;

  get args => ModalRoute.of(this)?.settings.arguments as Map<dynamic, dynamic>;

  TextDirection get textDirection => Directionality.of(this);

  double get heightPadding =>
      height - ((mediaQuery.padding.top + mediaQuery.padding.bottom) / 100.0);
  double get widthPadding =>
      height - ((mediaQuery.padding.left + mediaQuery.padding.right) / 100.0);
  double heightPer(double per) => height * per / 100;
  double widthPer(double per) => width * per / 100;
  double heightPaddingPer(double per) => heightPadding * per / 100;
  double widthPaddingPer(double per) => widthPadding * per / 100;

  hideKeyboard() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
