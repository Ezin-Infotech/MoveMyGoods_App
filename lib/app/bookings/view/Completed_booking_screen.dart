import 'package:flutter/material.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class CompletedBookingScreen extends StatelessWidget {
  const CompletedBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    return CommonScaffold(
        children: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Complected Bookings',
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: const Color(0xff0076E3),
              ),
            ),
            // Icon()
          ],
        ),
        SizeBoxH(Responsive.height * 0.5),
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
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
              text: 'Booking Id # ',
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
              children: <TextSpan>[
                TextSpan(
                  text: '12345678778',
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ]),
        ),
        Container(
          width: Responsive.width * 100,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                width: 1,
                color: const Color(0xffE9E9E9),
              ),
              boxShadow: const [
                BoxShadow(
                  color:
                      Color(0x40000000), // Color with opacity (hex value: 0x40)
                  offset: Offset(0,
                      1), // Offset from the top-left corner (0px horizontal, 1px vertical)
                  blurRadius: 14.5, // Blur radius (14.5px)
                  spreadRadius: -3, // Spread radius (-3px)
                )
              ]),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeBoxH(Responsive.height * 0.2),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextField(
                        textField: 'Date :',
                      ),
                      TextWidgets(
                        text: '19-02-2024',
                      )
                    ],
                  ),
                  Row(
                    children: [
                      TextField(
                        textField: 'Time :',
                      ),
                      TextWidgets(
                        text: '19-02-2024',
                      )
                    ],
                  ),
                ],
              ),
              SizeBoxH(Responsive.height * 0.2),
              const TextField(
                textField: 'Source: ',
              ),
              const TextWidgets(
                text:
                    'Mysuru, Karnataka, India,Mysore Division,Karnataka,India  ',
              ),
              SizeBoxH(Responsive.height * 0.2),
              const TextField(
                textField: 'Destination:  ',
              ),
              const TextWidgets(
                text:
                    'Mysuru, Karnataka, India,Mysore Division,Karnataka,India  ',
              ),
              SizeBoxH(Responsive.height * 0.2),
              Row(
                children: [
                  const Column(
                    children: [
                      TextField(
                        textField: 'Goods Type: ',
                      ),
                      TextWidgets(
                        text: 'Automobile',
                      ),
                    ],
                  ),
                  const SizeBoxV(10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        textField: 'Estimated Price:',
                      ),
                      TextWidgets(
                        text: '₹ 394 /-',
                      ),
                    ],
                  ),
                  const SizeBoxV(20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizeBoxH(20),
                      Text(
                        'View Price Details',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: const Color(0xff0D9F00),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizeBoxH(Responsive.height * 2),
        Container(
          width: Responsive.width * 100,
          decoration: BoxDecoration(
              color: AppColors.kLight,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                width: 1,
                color: const Color(0xffE9E9E9),
              ),
              boxShadow: const [
                BoxShadow(
                  color:
                      Color(0x40000000), // Color with opacity (hex value: 0x40)
                  offset: Offset(0,
                      1), // Offset from the top-left corner (0px horizontal, 1px vertical)
                  blurRadius: 14.5, // Blur radius (14.5px)
                  spreadRadius: -3, // Spread radius (-3px)
                )
              ]),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Price Details',
                style: context.textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const Divider(
                color: Color(0xffDDDDDD),
                height: Checkbox.width,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextField(
                        textField: 'Cistance',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextField(
                        textField: 'Net Amount  ',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextField(
                        textField: 'Base Fare ',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextField(
                        textField: 'Price Per Km  ',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextField(
                        textField: 'Labour Cost ',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextField(
                        textField: 'CGST ',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextField(textField: 'GST ')
                    ],
                  ),
                  const VerticalDivider(
                    width: 10,
                    thickness: 1,
                    indent: 20,
                    endIndent: 0,
                    color: Color.fromARGB(255, 83, 13, 13),
                  ),
                  Column(
                    children: [
                      SizeBoxH(Responsive.height * 1),
                      const TextWidgets(
                        text: '3.5',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextWidgets(
                        text: '3.5',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextWidgets(
                        text: '3.5',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextWidgets(
                        text: '3.5',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextWidgets(
                        text: '3.5',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextWidgets(
                        text: '3.5',
                      ),
                      SizeBoxH(Responsive.height * 1),
                      const TextWidgets(
                        text: '3.5',
                      ),
                      SizeBoxH(Responsive.height * 1),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: Color(0xffDDDDDD),
                height: Checkbox.width,
                thickness: 1,
              ),
              SizeBoxH(Responsive.height * 1),
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
        )
      ],
    ));
  }
}

class TextField extends StatelessWidget {
  final String? textField;
  const TextField({super.key, this.textField});

  @override
  Widget build(BuildContext context) {
    return Text(
      textField ?? '',
      style: context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: const Color(0xff979797)),
    );
  }
}

class TextWidgets extends StatelessWidget {
  final String? text;
  const TextWidgets({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
    );
  }
}
