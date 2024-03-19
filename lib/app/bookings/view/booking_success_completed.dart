import 'package:flutter/material.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
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
              'Your order has been',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: const Color(0xff0D9F00)),
            ),
            Text(
              'Successfully Completed',
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
                  print(
                      '${Urls.imageBaseUrl}${obj.bookingDetail.data!.vehicleImage!.path}');
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
                                    '${Urls.imageBaseUrl}${obj.bookingDetail.data!.vehicleImage!.path}',
                                  ),
                                  fit: BoxFit.contain)),
                        ),
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const OrderSlipHeadText(
                        Heading: 'Order Summary',
                      ),
                      TextFieldAndText(
                        textField: 'Order ID :',
                        text: obj.bookingDetail.data!.id.toString() ?? '',
                      ),
                      TextFieldAndText(
                        textField: 'Source : ',
                        text: obj.bookingDetail.data!.sCity ?? '',
                      ),
                      TextFieldAndText(
                        textField: 'Destination : ',
                        text: obj.bookingDetail.data!.dCity ?? '',
                      ),
                      TextFieldAndText(
                        textField: 'Goods Type : ',
                        text: obj.bookingDetail.data!.goodsTypeName!.name ?? '',
                      ),
                      TextFieldAndText(
                        textField: 'Goods Value : ',
                        text:
                            obj.bookingDetail.data!.goodsvalue.toString() ?? '',
                      ),
                      TextFieldAndText(
                        textField: 'Number of Labours : ',
                        text:
                            obj.bookingDetail.data!.numberofLabours.toString(),
                      ),
                      TextFieldAndText(
                        textField: 'Goods Weight :',
                        text: obj.bookingDetail.data!.goodsWeightName!.weight
                            .toString(),
                      ),
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
                      const OrderSlipHeadText(
                        Heading: 'Receiver Details',
                      ),
                      TextFieldAndText(
                        textField: 'Name :',
                        text: obj.bookingDetail.data!.consigneeName.toString(),
                      ),
                      // const TextFieldAndText(
                      //   textField: 'Email : ',
                      //   text: '#1234567890',
                      // ),
                      TextFieldAndText(
                        textField: 'Mobile No: ',
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
                      TextFieldAndText(
                        textField: 'PAN No: ',
                        text: obj.bookingDetail.data!.consigneePan.toString(),
                      ),
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
                      const OrderSlipHeadText(
                        Heading: 'Shipper Details',
                      ),
                      TextFieldAndText(
                        textField: 'Name :',
                        text: obj.bookingDetail.data!.consignorName.toString(),
                      ),
                      // const TextFieldAndText(
                      //   textField: 'Email : ',
                      //   text: '#1234567890',
                      // ),
                      TextFieldAndText(
                        textField: 'Mobile No: ',
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
                      TextFieldAndText(
                        textField: 'PAN No: ',
                        text: obj.bookingDetail.data!.consigneePan.toString(),
                      ),
                      // const TextFieldAndText(
                      //   textField: 'GST:',
                      //   text: '#1234567890',
                      // ),
                      SizeBoxH(Responsive.height * 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Amount ₹ ${obj.bookingDetail.data!.totalAmount ?? ''} /-',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: const Color(0xff0D9F00),
                            ),
                          ),
                        ],
                      ),
                      SizeBoxH(Responsive.height * 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonWidgets(
                            buttonText: 'Back to Home',
                            onPressed: () {
                              // context.push(const LoginScreen());
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
  final String? Heading;
  const OrderSlipHeadText({
    super.key,
    this.Heading,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      Heading ?? '',
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
      children: [
        SizeBoxH(Responsive.height * 0.5),
        Row(
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
