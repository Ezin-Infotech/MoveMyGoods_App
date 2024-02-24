import 'package:flutter/material.dart';

class SmallBoxontainerWidget extends StatelessWidget {
  final Color? numberColor;
  const SmallBoxontainerWidget({this.numberColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      height: 75,
      decoration: const BoxDecoration(
          color: Color(0xffE8E8E8),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          const Text(
            'All bookings',
            style: TextStyle(
                // color: Color(0xffFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
          ),
          Text('0',
              style: TextStyle(
                  color: numberColor ?? const Color(0xffFFFFFF),
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins'))
        ],
      ),
    );
  }
}
