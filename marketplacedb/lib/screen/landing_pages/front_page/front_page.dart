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
import 'package:marketplacedb/screen/sign_up_pages/phone/phone_widgets.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbars.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class FrontPage extends StatefulWidget {
  final bool? logoutMessage;

  const FrontPage({Key? key, this.logoutMessage}) : super(key: key);

  @override
  State<FrontPage> createState() =>
      // ignore: no_logic_in_create_state
      FrontPageState(logoutMessage: logoutMessage ?? false);
}

class FrontPageState extends State<FrontPage> {
  final bool logoutMessage;
  FrontPageState({required this.logoutMessage});
  final controller = Get.put(AuthenticationController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (logoutMessage) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showLogoutSnackBar();
      });
    }
  }

  void showLogoutSnackBar() async {
    successSnackBar(context, "Successfully Logged Out", 'Success');
  }

  Future<void> termsOfServices(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        double screenHeight = MediaQuery.of(context).size.height;
        double bottomSheetHeight =
            screenHeight * 0.5; // 40% of the screen height

        return TermsOfServicesContainer(bottomSheetHeight: bottomSheetHeight);
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: MPSpacingStyle.paddingWithAppBarHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const LoginHeader(),
                    const SizedBox(height: MPSizes.spaceBtwSections / 2),
                    LoginForm(
                        emailController: emailController,
                        passwordController: passwordController),
                    const LoginForgetPasswordRow(),
                    const SizedBox(height: MPSizes.spaceBtwItems),
                    SizedBox(
                        width: double.infinity,
                        child: Obx(() => MPPrimaryButton(
                            isLoading: authController.isLoading.value,
                            onPressed: () async {
                              await controller.login(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text);
                            },
                            text: MPTexts.signIn))),
                    const SizedBox(height: MPSizes.spaceBtwSections * 1.5),
                    const MPDividerWithText(
                        text: MPTexts.loginDividerSignUpWith),
                    const SizedBox(height: MPSizes.spaceBtwItems),
                    const SocialLoginButtons(),
                  ],
                ))));
  }
}
