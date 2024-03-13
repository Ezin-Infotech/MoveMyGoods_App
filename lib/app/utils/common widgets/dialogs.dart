import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mmg/app/utils/app%20style/app_images.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'button.dart';

void commonBottomSheetDialog(BuildContext context, double max, double initial,
    double min, Widget child, Color? backgroundColor) {
  showModalBottomSheet(
    context: context, backgroundColor: backgroundColor ?? Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),

    isScrollControlled: true, // set this to true
    builder: (_) {
      return DraggableScrollableSheet(
        maxChildSize: max,
        initialChildSize: initial,
        minChildSize: min,
        expand: false,
        builder: (_, controller) {
          return Row(
            children: [
              Container(
                //color: Colors.black,
                padding: const EdgeInsets.all(0),

                child: SingleChildScrollView(
                  controller: controller,
                  child: child,
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

errorBottomSheetDialogs({
  required BuildContext context,
  required String title,
  required String subtitle,
  String errorStatus = 'error',
  Widget? button,
  bool isDismissible = true,
  bool enableDrag = true,
  required bool isdarkmode,
}) {
  showModalBottomSheet(
    isDismissible: true,
    enableDrag: enableDrag,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(25),
        topStart: Radius.circular(25),
      ),
    ),
    builder: (context) {
      return CommonSheetWidget(
        subtitle: subtitle,
        title: title,
        button: button,
        errorstatus: errorStatus,
      );
    },
  );
}

class CommonSheetWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? button;
  final String errorstatus;
  const CommonSheetWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.button,
    this.errorstatus = 'error',
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsetsDirectional.only(
        start: 0,
        end: 0,
        bottom: 5,
        top: 5,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //    if (!kIsWeb) CommonSheetHolder(),
              SizedBox(height: context.height * 0.03),
              errorstatus == 'error'
                  ? Image.asset(
                      'assets/error_image.png',
                      scale: 1,
                      color: const Color(0xffF34D3F),
                    )
                  : Image.asset(
                      'assets/error_image.png',
                      scale: 1,
                      color: const Color(0xffF34D3F),
                    ),
              const SizeBoxH(12),
              SizedBox(
                height: context.height * 0.02,
              ),
              Text(
                title,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: context.textTheme.displaySmall!.copyWith(fontSize: 16),
              ),
              subtitle == ''
                  ? Container()
                  : SizedBox(
                      height: context.height * 0.015,
                    ),
              subtitle == ''
                  ? Container()
                  : Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style:
                          context.textTheme.titleMedium!.copyWith(fontSize: 16),
                    ),
              const SizeBoxH(12),
              button == null
                  ? Column(
                      children: [
                        SizeBoxH(context.height * 0.02),
                        ButtonWidgets(
                          buttonText: 'Close',
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        SizeBoxH(context.height * 0.03),
                      ],
                    )
                  : button!,
            ],
          ),
        ],
      ),
    );
  }
}

void failurtoast({title, duration = 2}) {
  HapticFeedback.lightImpact();
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  } else {
    Get.showSnackbar(
      GetSnackBar(
        icon: const Icon(
          Icons.warning_amber_outlined,
          size: 18,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        message: title != '' ? title : 'Something went wrong',
        duration: Duration(seconds: duration),
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
        isDismissible: true,
        dismissDirection: DismissDirection.down,
      ),
    );
  }
}

void successtoast({title, duration = 2}) {
  Get.showSnackbar(
    GetSnackBar(
      icon: const Icon(
        Icons.done,
        size: 18,
        color: Colors.white,
      ),
      backgroundColor: Colors.green,
      message: title != '' ? title : 'Something went wrong',
      duration: Duration(seconds: duration),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      isDismissible: true,
      dismissDirection: DismissDirection.down,
    ),
  );
}
