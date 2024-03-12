import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';

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
                padding: const EdgeInsets.only(left: 14, right: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizeBoxH(Responsive.height * 1),
                    const OrderSlipHeadText(
                      Heading: 'Order Summary',
                    ),
                    const TextFieldAndText(
                      textField: 'Order ID :',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Source : ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Source : ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Goods Type : ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Goods Value : ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Number of Labours : ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Goods Weight :',
                      text: '#1234567890',
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
                    const TextFieldAndText(
                      textField: 'Name :',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Email : ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Mobile No: ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Referance No: ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Location : ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'PAN No: ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'GST:',
                      text: '#1234567890',
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
                      Heading: 'Shipper Details',
                    ),
                    const TextFieldAndText(
                      textField: 'Name :',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Email : ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Mobile No: ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Referance No: ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'Location : ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'PAN No: ',
                      text: '#1234567890',
                    ),
                    const TextFieldAndText(
                      textField: 'GST:',
                      text: '#1234567890',
                    ),
                    SizeBoxH(Responsive.height * 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Amount ₹ 394 /-',
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
                ),
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
            Text(
              textField ?? '',
              style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black),
            ),
            Text(
              text ?? '',
              style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black),
            )
          ],
        ),
      ],
    );
  }
}
