import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/bookings/view/booking_details_screen.dart';
import 'package:mmg/app/bookings/view/booking_screen.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/backend/urls.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class BookingSuccessFullyCompletedScreen extends StatelessWidget {
  const BookingSuccessFullyCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isBackButton: false,
      children: Container(
        width: Responsive.width * 100,
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 1),
              blurRadius: 11.8,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/success1.gif'))),
              child: Center(
                child: Icon(
                  Icons.check_rounded,
                  size: 24,
                  color: AppColors.kLight,
                ),
              ),
            ),
            // Image.asset('assets/success1.gif'),
            Text(
              'Your Booking has been'.tr,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: const Color(0xff0D9F00)),
            ),
            Text(
              'Successfully Placed'.tr,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: const Color(0xff0D9F00),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffF6F7FF),
                  border: Border.all(
                    width: 1.5,
                    color: const Color(0xffD4D4D4),
                  ),
                ),
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Consumer<BookingProvider>(builder: (context, obj, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    '${Urls.imageBaseUrl}${obj.bookingDetail.data!.vehicleImage!['path']}',
                                  ),
                                  fit: BoxFit.contain)),
                        ),
                      ),
                      SizeBoxH(Responsive.height * 1),
                      OrderSlipHeadText(
                        heading: 'Order Summary'.tr,
                      ),
                      SizeBoxH(Responsive.height * 1),
                      TextFieldAndText(
                        textField: '${"Order ID".tr} :',
                        text: obj.bookingDetail.data!.id.toString(),
                      ),
                      SizeBoxH(Responsive.height * 1),
                      TextFieldAndText(
                        textField: '${"Source".tr} : ',
                        text: obj.bookingDetail.data!.sStreet ?? '',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      TextFieldAndText(
                        textField: '${"Destination".tr} : ',
                        text: obj.bookingDetail.data!.dStreet ?? '',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      TextFieldAndText(
                        textField: '${"Goods Type".tr} : ',
                        text: obj.bookingDetail.data!.goodsTypeName!.name ?? '',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      TextFieldAndText(
                        textField: '${"Goods Value".tr} : ',
                        text: obj.bookingDetail.data!.goodsvalue.toString(),
                      ),
                      SizeBoxH(Responsive.height * 1),

                      TextFieldAndText(
                        textField: '${"Goods Weight".tr} :',
                        text: obj.bookingDetail.data!.goodsWeightName!.weight
                            .toString(),
                      ),
                      SizeBoxH(Responsive.height * 1),
                      SizeBoxH(Responsive.height * 2.5),
                      MediaQuery.removeViewPadding(
                        context: context,
                        removeLeft: true,
                        removeRight: true,
                        child: const Divider(
                          thickness: 1,
                          height: 1,
                          color: Color(0xffC1C1C1),
                        ),
                      ),
                      SizeBoxH(Responsive.height * 1),
                      OrderSlipHeadText(
                        heading: 'Receiver Details'.tr,
                      ),
                      SizeBoxH(Responsive.height * 1),
                      TextFieldAndText(
                        textField: '${"Name".tr} :',
                        text: obj.bookingDetail.data!.consigneeName.toString(),
                      ),
                      // const TextFieldAndText(
                      //   textField: 'Email : ',
                      //   text: '#1234567890',
                      // ),
                      TextFieldAndText(
                        textField: '${"Mobile No".tr}: ',
                        text:
                            obj.bookingDetail.data!.consigneeNumber.toString(),
                      ),
                      // const TextFieldAndText(
                      //   textField: 'Referance No: ',
                      //   text: '#1234567890',
                      // ),
                      // const TextFieldAndText(
                      //   textField: 'Location : ',
                      //   text: '#1234567890',
                      // ),
                      // TextFieldAndText(
                      //   textField: 'PAN No: ',
                      //   text: obj.bookingDetail.data!.consigneePan.toString(),
                      // ),
                      // const TextFieldAndText(
                      //   textField: 'GST:',
                      //   text: '#1234567890',
                      // ),
                      SizeBoxH(Responsive.height * 2.5),
                      MediaQuery.removeViewPadding(
                        context: context,
                        removeLeft: true,
                        removeRight: true,
                        child: const Divider(
                          thickness: 1,
                          height: 1,
                          color: Color(0xffC1C1C1),
                        ),
                      ),
                      SizeBoxH(Responsive.height * 1),
                      OrderSlipHeadText(
                        heading: 'Shipper Details'.tr,
                      ),
                      TextFieldAndText(
                        textField: '${"Name".tr} :',
                        text: obj.bookingDetail.data!.consignorName.toString(),
                      ),
                      // const TextFieldAndText(
                      //   textField: 'Email : ',
                      //   text: '#1234567890',
                      // ),
                      TextFieldAndText(
                        textField: '${"Mobile No".tr}: ',
                        text:
                            obj.bookingDetail.data!.consignorNumber.toString(),
                      ),
                      // const TextFieldAndText(
                      //   textField: 'Referance No: ',
                      //   text: '#1234567890',
                      // ),
                      // const TextFieldAndText(
                      //   textField: 'Location : ',
                      //   text: '#1234567890',
                      // ),
                      // TextFieldAndText(
                      //   textField: 'PAN No: ',
                      //   text: obj.bookingDetail.data!.consigneePan.toString(),
                      // ),
                      // const TextFieldAndText(
                      //   textField: 'GST:',
                      //   text: '#1234567890',
                      // ),
                      SizeBoxH(Responsive.height * 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${"Total Amount".tr} ₹ ${double.parse(obj.bookingDetail.data!.totalAmount.toString()).formatTwoDigitsAfterDecimal()}/-',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xff0D9F00)),
                          ),
                          IconButton(
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                size: 28,
                              ),
                              onPressed: () => priceDialog(
                                    context: context,
                                    netAmount: obj
                                        .bookingDetail.data!.actualFare
                                        .toString(),
                                    baseFare: obj.bookingDetail.data!.baseFare
                                        .toString(),
                                    cgst:
                                        obj.bookingDetail.data!.cgst.toString(),
                                    costPerKm: obj.bookingDetail.data!.perKm
                                        .toString(),
                                    distance: obj.bookingDetail.data!.distance
                                        .toString(),
                                    labourCost: obj
                                        .bookingDetail.data!.labourCharges
                                        .toString(),
                                    sgst:
                                        obj.bookingDetail.data!.sgst.toString(),
                                    totalAmount: obj
                                        .bookingDetail.data!.totalAmount
                                        .toString(),
                                  )),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       '${"Total Amount".tr} ₹ ${obj.bookingDetail.data!.totalAmount ?? ''} /-',
                      //       textAlign: TextAlign.center,
                      //       style: context.textTheme.bodyLarge?.copyWith(
                      //         fontWeight: FontWeight.w700,
                      //         fontSize: 16,
                      //         color: const Color(0xff0D9F00),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizeBoxH(Responsive.height * 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonWidgets(
                            buttonText: 'Back to Home'.tr,
                            onPressed: () {
                              Get.back();
                              // context.back()
                            },
                          ),
                        ],
                      ),
                      SizeBoxH(Responsive.height * 3),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSlipHeadText extends StatelessWidget {
  final String? heading;
  const OrderSlipHeadText({
    super.key,
    this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      heading ?? '',
      style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
    );
  }
}

class TextFieldAndText extends StatelessWidget {
  final String? textField;
  final String? text;
  const TextFieldAndText({
    super.key,
    this.textField,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizeBoxH(Responsive.height * 0.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                textField ?? '',
                style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black),
              ),
            ),
            const SizeBoxV(10),
            Expanded(
              child: Text(
                text ?? '',
                style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ],
    );
  }
}
