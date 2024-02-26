import 'package:flutter/material.dart';
import 'package:mmg/app/settings/view%20model/settings_controller.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      children: Consumer<SettingsProvider>(builder: (context, value, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Bookings',
                  style: context.textTheme.bodyLarge!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Icon(
                  Icons.filter_list_rounded,
                  size: 18,
                )
              ],
            ),
            const SizeBoxH(8),
            const Divider(
              color: Color(0xffDFDFDF),
              thickness: 1,
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Booking Id # ',
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '12345678778',
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      const SizeBoxH(8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(145, 158, 158, 158),
                                offset: Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                            border: Border.all(
                                color: AppColors.black.withOpacity(0.1))),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date',
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                      color: const Color(0xff979797),
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '19-02-2024',
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            const SizeBoxV(20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                      color: const Color(0xff979797),
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '10:22 PM',
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            const SizeBoxV(20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status',
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                      color: const Color(0xff979797),
                                      fontWeight: FontWeight.w400),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      color: Color(0xff0076E3),
                                    ),
                                    const SizeBoxV(8),
                                    Text(
                                      'Completed',
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                              color: const Color(0xff0076E3),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizeBoxH(10),
                itemCount: 10)
          ],
        );
      }),
    );
  }
}
