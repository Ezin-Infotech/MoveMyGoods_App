import 'package:flutter/material.dart';
import 'package:mmg/app/utils/app%20style/app_images.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primary),
      padding: EdgeInsets.only(right: 16,left: 16,top: 28,bottom: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(AppImages.whiteLogo),
                    const Column(
                      children: [
                        Text('Move My Goods'),
                        Text('Digital Logistic Platform')
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const CircleAvatar(
            maxRadius: 30,
          )
        ],
      ),
    );
  }
}
