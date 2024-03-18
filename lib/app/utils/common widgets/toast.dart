import 'package:flutter/material.dart';

import '../../settings/view/widgets/theme.dart';
import '../app style/responsive.dart';

bool _isToastShowing = false;

void toast(BuildContext context,
    {String? title, int duration = 2, Color? backgroundColor}) {
  if (_isToastShowing) return;

  _isToastShowing = true;

  final scaffold = ScaffoldMessenger.of(context);
  scaffold
      .showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          duration: Duration(seconds: duration),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          width: Responsive.width * 90,
          content: Container(
            height: Responsive.height * 3,
            alignment: Alignment.center,
            child: Text(
              title ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: backgroundColor == const Color(0xFFFFDD11)
                      ? AppConstants.black
                      : Colors.white),
            ),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      )
      .closed
      .then((reason) {
    _isToastShowing = false;
  });
}
