import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/snackbar.dart';
import 'package:marketplacedb/networks/googleSignIn.dart';
import 'package:marketplacedb/screen/signin_page.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/screen/signup_pages/signuppage_name.dart';

class UkaykoLogo extends StatelessWidget {
  final double width;
  final double height;
  const UkaykoLogo({
    this.width = 20,
    this.height = 20,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      width: width,
      height: height,
      image: const AssetImage('flutter_images/UkaykoLogo.png'),
      fit: BoxFit.contain,
    );
  }
}

class signupProcess extends StatelessWidget {
  const signupProcess({
    super.key,
  });

  Future initStorage() async {
    final storage = GetStorage();
    await storage.erase();
    // Get all keys in the storage
    final allKeys = storage.getKeys();
    print('asdad');
    // Loop through all keys and print the key and its corresponding value
    for (var key in allKeys) {
      final value = storage.read(key);
      print('$key: $value');
    }
  }

  void signupButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpPagename()));
  }

  Future googlebutton(BuildContext context) async {
    // await GoogleSignAPI.logout();
    final userData = await GoogleSignAPI.login();

    final response = await authController.loginGoogle(userData?.email);
    // print(response);
    if (response == 0) {
      await GoogleSignAPI.logout();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignUpPagename(socialLogin: true)));
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

  void fbbutton(BuildContext context) async {
    await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email']).then((value) async {
      final data = await FacebookAuth.instance.getUserData();
      print(data);

      final response = await authController.loginFacebook((data['email']));
      if (response == 0) {
        await FacebookAuth.instance.logOut();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SignUpPagename(socialLogin: true)));
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
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GoogleButton(onTap: () => googlebutton(context)),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: FBButton(
                onTap: () {
                  fbbutton(context);
                },
              ),
            ),
            LargeBlackButton(
              text: "Sign Up",
              isDisabled: false,
              onPressed: () async {
                await initStorage();
                signupButton(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: "Sign in",
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          signInButton(context);
                        },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Expanded(
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
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

