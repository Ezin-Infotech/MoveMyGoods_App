import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/bookings/view/widgets/drop_down_widgets.dart';
import 'package:mmg/app/bookings/view/widgets/map_screen.dart';
import 'package:mmg/app/utils/app%20style/app_images.dart';

import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/textform.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    return CommonScaffold(
      children: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MapScreen()
          const MapWidgets(),
          const CustomText(
            text: 'Source *',
          ),
          const SizeBoxH(8),
          const DropdownInsideTextFormField(),
          BookingTextFieldWidgets(
            hintText: 'mysore,karnadaka',
            controller: bookingProvider.destinationController,
            labeText: 'Destination *',
          ),
          const SizeBoxH(10),
          const CustomText(
            text: 'Goods Type *',
          ),
          const SizeBoxH(8),
          const DropdownInsideTextFormField(),
          BookingTextFieldWidgets(
            hintText: '300',
            controller: bookingProvider.goodsValueController,
            labeText: 'Goods Value *',
            keyboardType: TextInputType.number,
          ),
          BookingTextFieldWidgets(
            hintText: '6',
            controller: bookingProvider.numberOfLabourController,
            labeText: 'Number of Labours *',
            keyboardType: TextInputType.number,
          ),
          const SizeBoxH(10),
          const CustomText(
            text: 'Goods Weight *',
          ),
          const SizeBoxH(8),
          const DropdownInsideTextFormField(),
          const SizeBoxH(8),
          Container(
            decoration: BoxDecoration(
                color: AppColors.bgColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 0, // Spread radius
                    blurRadius: 8, // Blur radius
                    // offset: const Offset(0, 3),
                  ),
                  BoxShadow(
                    color: AppColors.grey.withOpacity(0.8), // Shadow color
                    spreadRadius: 0, // Spread radius
                    blurRadius: 2, // Blur radius
                    // offset: const Offset(0, 3),
                  ),
                  BoxShadow(
                    color: AppColors.grey.withOpacity(0.7), // Shadow color
                    spreadRadius: 0, // Spread radius
                    blurRadius: 1, // Blur radius
                    // offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: const Color(0xffDBDBDB))),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        const MyToggleIconButton(),
                        Text(
                          'Upto 750kg  ₹ 312.5',
                          style: context.textTheme.bodyMedium!.copyWith(),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          SizeBoxH(Responsive.height * 2),
          Image.asset(
            AppImages.smallvehicleImage,
            width: Responsive.width * 216,
            height: Responsive.height * 16,
          ),

          SizeBoxH(Responsive.height * 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total Amount:394/-',
                style: context.textTheme.displaySmall!.copyWith(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: const Color(0xff0D9F00)),
              ),
              SizeBoxV(Responsive.width * 25),
              const Icon(
                Icons.arrow_drop_down,
                size: 28,
              )
            ],
          ),
          SizeBoxH(Responsive.height * 0.7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '*The price is an indicative and actual pricemay vary ',
                style: context.textTheme.displaySmall!.copyWith(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color(0xffF90000)),
              ),
            ],
          ),
          SizeBoxH(Responsive.height * 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidgets(
                buttonText: 'Continue',
                onPressed: () {
                  // context.push(const LoginScreen());
                },
              ),
            ],
          ),
          SizeBoxH(Responsive.height * 4),
          Text(
            '*Receiver Details',
            style: context.textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: const Color(0xff222222)),
          ),
          BookingTextFieldWidgets(
            hintText: 'Name',
            controller: bookingProvider.receiverNameController,
            labeText: 'Name',
          ),
          BookingTextFieldWidgets(
            hintText: 'Email',
            controller: bookingProvider.receiverEmailController,
            labeText: 'Email Address',
            keyboardType: TextInputType.emailAddress,
          ),
          BookingTextFieldWidgets(
            hintText: 'Number',
            controller: bookingProvider.receiverMobileNoController,
            labeText: 'Mobile No.',
            keyboardType: TextInputType.phone,
          ),
          const SizeBoxH(10),
          const CustomText(
            text: 'Reference Numbers',
          ),
          const SizeBoxH(8),
          const DropdownInsideTextFormField(),

          const SizeBoxH(10),
          const CustomText(
            text: 'Location',
          ),
          const SizeBoxH(8),
          const DropdownInsideTextFormField(),
          BookingTextFieldWidgets(
            hintText: '(eg.DUMPA1234)',
            controller: bookingProvider.receiverPanNoController,
            labeText: 'PAN No.',
          ),
          BookingTextFieldWidgets(
            hintText: '(eg.GHXXXXXXXX000)',
            controller: bookingProvider.receiverGstNoController,
            labeText: 'GST No.',
          ),
          SizeBoxH(Responsive.height * 2),
          Text(
            '*Shipper Details',
            style: context.textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: const Color(0xff222222)),
          ),
          // SizeBoxH(Responsive.height * 1),
          BookingTextFieldWidgets(
            hintText: 'Name',
            controller: bookingProvider.shipperNameController,
            labeText: 'Name',
          ),
          BookingTextFieldWidgets(
            hintText: 'Email',
            controller: bookingProvider.shipperemailController,
            labeText: 'Email Address',
            keyboardType: TextInputType.emailAddress,
          ),
          BookingTextFieldWidgets(
            hintText: 'Number',
            controller: bookingProvider.shipperMobileNoController,
            labeText: 'Mobile No.',
            keyboardType: TextInputType.phone,
          ),

          BookingTextFieldWidgets(
            hintText: '(eg.DUMPA1234)',
            controller: bookingProvider.shipperpanNOController,
            labeText: 'PAN No.',
          ),
          BookingTextFieldWidgets(
            hintText: '(eg.GHXXXXXXXX000)',
            controller: bookingProvider.shipperGstNoController,
            labeText: 'GST No.',
          ),
          SizeBoxH(Responsive.height * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidgets(
                buttonText: 'Proceed to Pay',
                onPressed: () {
                  // context.push(const LoginScreen());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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

List<String> items = ['Item 1', 'Item 2', 'Item 3'];

class MyToggleIconButton extends StatefulWidget {
  const MyToggleIconButton({super.key});

  @override
  _MyToggleIconButtonState createState() => _MyToggleIconButtonState();
}

class _MyToggleIconButtonState extends State<MyToggleIconButton> {
  bool isToggled = false; // Initial state

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isToggled
          ? const Icon(Icons.favorite, color: Colors.red)
          : const Icon(Icons.favorite_border),
      onPressed: () {
        setState(() {
          isToggled = !isToggled;
        });
      },
    );
  }
}

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
