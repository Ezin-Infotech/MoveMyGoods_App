import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/multyLanguage/controller/language_controller.dart';
import 'package:mmg/app/utils/enums.dart';
import 'package:provider/provider.dart';

import '../app style/app_images.dart';
import '../app style/colors.dart';

class CommonScaffold extends StatefulWidget {
  final Widget children;
  final Widget? floatingActionButton;
  final bool isBackButton;
  final double? padding;
  final bool? isSettings;
  const CommonScaffold(
      {super.key,
      required this.children,
      required this.isBackButton,
      this.isSettings = false,
      this.floatingActionButton,
      this.padding = 16.0});

  @override
  State<CommonScaffold> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                        widget.isBackButton
                            ? IconButton(
                                onPressed: () => Get.back(),
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 20,
                                  color: AppColors.kLight,
                                ),
                              )
                            : const SizedBox.shrink(),
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
              widget.isSettings == true
                  ? PopupMenuButton(
                      onSelected: (value) {},
                      surfaceTintColor: Colors.transparent,
                      icon: const Icon(
                        Icons.translate,
                        color: Colors.white,
                      ),
                      iconColor: const Color.fromARGB(255, 255, 255, 255),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      itemBuilder: (context) => AppConstants.languages.map((e) {
                        return PopupMenuItem<String>(
                          value: e.languageCode.toString(),
                          onTap: () {
                            var locale = Locale(e.languageCode.toString());
                            Get.updateLocale(locale);
                            languageController.saveLanguage(e.languageCode);
                            setState(() {});
                          },
                          child: Text(e.languageName.toString()),
                        );
                      }).toList(),
                    )
                  : auth.isUserLogged
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
                                  backgroundImage:
                                      AssetImage('assets/avathar1.png'),
                                )
                      : const CircleAvatar(
                          maxRadius: 20,
                          backgroundImage: AssetImage('assets/avathar1.png'),
                        )
            ],
          );
        }),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(widget.padding ?? 16.0),
          child: widget.children,
        ),
      ),
    );
  }
}
