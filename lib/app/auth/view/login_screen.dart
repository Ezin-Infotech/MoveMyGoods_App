import 'package:flutter/material.dart';
import 'package:mmg/app/auth/view/view%20model/auth_provider.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/common%20widgets/app_bar.dart';
import 'package:mmg/app/utils/common%20widgets/textform.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const PreferredSize(
          preferredSize: Size(375, 85), child: AppBarWidget()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            // width: 243,
            // height: 432,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 36,
                ),
                const Text(
                  'Welcome Back ',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const LabelText(
                  text: 'Email',
                ),
                CommonTextForm(
                  onChanged: (p0) {},
                  controller: authProvider.emailController,
                  fillColor: AppColors.bgColor,
                  hintText: 'exampleple@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                const LabelText(
                  text: 'Email',
                ),
                CommonTextForm(
                  onChanged: (p0) {},
                  controller: authProvider.emailController,
                  fillColor: AppColors.bgColor,
                  hintText: 'exampleple@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String? text;
  const LabelText({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'Email',
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
