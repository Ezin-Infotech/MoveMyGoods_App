import 'package:flutter/material.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/utils/enums.dart';
import 'package:provider/provider.dart';

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
        title: Consumer<AuthProvider>(builder: (context, auth, _) {
          return Row(
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
                        const Text(
                          'Move My Goods',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
              auth.isUserLogged
                  ? auth.getUserProfilePicStatus ==
                          GetUserProfilePicStatus.loading
                      ? const CircularProgressIndicator()
                      : auth.userProfilePic!.isNotEmpty
                          ? CircleAvatar(
                              maxRadius: 20,
                              backgroundImage: NetworkImage(
                                  "https://storage.googleapis.com/common-mmg/${auth.userProfilePic![0].path}"),
                            )
                          : const CircleAvatar(
                              maxRadius: 20,
                              backgroundImage: AssetImage('assets/avathar.png'),
                            )
                  : const CircleAvatar(
                      maxRadius: 20,
                      backgroundImage: AssetImage('assets/avathar.png'),
                    )
            ],
          );
        }),
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
