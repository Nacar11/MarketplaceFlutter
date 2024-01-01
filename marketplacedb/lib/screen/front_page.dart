// ignore_for_file: use_build_context_synchronously, unused_import, avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/textfields.dart';
import 'package:marketplacedb/util/constants/app_constant.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:flutter/services.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:marketplacedb/networks/googleSignIn.dart';
import 'package:marketplacedb/screen/signin_page.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_name.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_phone.dart';

import '../common/widgets/screen_specific/Navigation.dart';

final authController = AuthenticationController();

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
    showSuccessSnackBar(context, "Successfully Logged Out", 'success');
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

  void signUpButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpPageName()));
  }

  Future googleButton(BuildContext context) async {
    // await GoogleSignAPI.logout();
    final userData = await GoogleSignAPI.login();

    final response = await authController.loginGoogle(userData?.email);
    // print(response);
    if (response == 0) {
      await GoogleSignAPI.logout();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignUpPagePhone(socialLogin: true)));
    } else if (response == 1) {
      await GoogleSignAPI.logout();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              const Navigation(hasSnackbar: 'welcomeMessage')));
    } else {
      await GoogleSignAPI.logout();
      showErrorHandlingSnackBar(context, 'Error Logging In', 'error');
    }
  }

  void signInButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignInPage()));
  }

  void facebookButton(BuildContext context) async {
    await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email']).then((value) async {
      final data = await FacebookAuth.instance.getUserData();
      print(data);

      final response = await authController.loginFacebook((data['email']));
      if (response == 0) {
        await FacebookAuth.instance.logOut();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SignUpPageName(socialLogin: true)));
      } else if (response == 1) {
        await FacebookAuth.instance.logOut();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                const Navigation(hasSnackbar: 'welcomeMessage')));
      } else {
        FacebookAuth.instance.logOut();
        showErrorHandlingSnackBar(context, 'Error Logging In', 'error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.height *
                        0.4, // Adjust the width as needed
                    height: MediaQuery.of(context).size.height *
                        0.55, // Adjust the height as needed
                    child: const MarketplaceLogo(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GoogleButton(onTap: () => googleButton(context)),
                    FBButton(
                      onTap: () {
                        facebookButton(context);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: RichText(
                  text: TextSpan(
                    text: "By continuing you agree to our ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: "Terms of Service",
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            termsOfServices(context);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
