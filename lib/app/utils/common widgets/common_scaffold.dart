import 'package:flutter/material.dart';
import '../app style/app_images.dart';
import '../app style/colors.dart';

class CommonScaffold extends StatelessWidget {
  final Widget children;
  final double? padding;
  const CommonScaffold(
      {super.key, required this.children, this.padding = 16.0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AppImages.whiteLogo,
                        width: 44,
                        height: 44,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Move My Goods',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            'Digital Logistic Platform',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const CircleAvatar(
              maxRadius: 20,
              backgroundImage: AssetImage('assets/avathar.png'),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(padding ?? 16.0),
          child: children,
        ),
      ),
    );
  }
}
