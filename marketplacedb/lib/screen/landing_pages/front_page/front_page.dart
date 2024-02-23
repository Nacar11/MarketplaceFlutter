// ignore_for_file: use_build_context_synchronously, unused_import, avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/styles/spacing_styles.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/dividers.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page_widgets.dart';
import 'package:marketplacedb/screen/sign_up_pages/pages/phone/phone_widgets.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page_controller.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FrontPageController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MPSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const LoginHeader(),
              const SizedBox(height: MPSizes.spaceBtwSections / 2),
              const LoginForm(),
              const SizedBox(height: MPSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: Obx(() => MPPrimaryButton(
                      isLoading: controller.isLoading.value,
                      onPressed: () async {
                        await controller.login();
                      },
                      text: MPTexts.signIn,
                    )),
              ),
              const SizedBox(height: MPSizes.spaceBtwSections * 1.5),
              const MPDividerWithText(text: MPTexts.loginDividerSignUpWith),
              const SizedBox(height: MPSizes.spaceBtwItems),
              const SocialLoginButtons(),
            ],
          ),
        ),
      ),
    );
  }
}


  // void facebookButton(BuildContext context) async {
  //   await FacebookAuth.instance
  //       .login(permissions: ['public_profile', 'email']).then((value) async {
  //     final data = await FacebookAuth.instance.getUserData();
  //     print(data);

  //     final response = await authController.loginFacebook((data['email']));
  //     if (response == 0) {
  //       await FacebookAuth.instance.logOut();
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => const SignUpPageName(socialLogin: true)));
  //     } else if (response == 1) {
  //       await FacebookAuth.instance.logOut();
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) =>
  //               const Navigation(hasSnackbar: 'welcomeMessage')));
  //     } else {
  //       FacebookAuth.instance.logOut();
  //       showErrorHandlingSnackBar(context, 'Error Logging In', 'error');
  //     }
  //   });
  // }