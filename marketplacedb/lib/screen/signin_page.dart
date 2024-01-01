// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/screen_specific/signinProcess.dart';
import 'package:marketplacedb/screen/ForgotPass/ForgotPass.dart';
import 'package:marketplacedb/screen/front_page.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/controllers/authenticationController.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';

class SignInPage extends StatefulWidget {
  final String? hasSnackbar;
  const SignInPage({Key? key, this.hasSnackbar}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SignInPage> createState() =>
      // ignore: no_logic_in_create_state
      _SignInPageState(hasSnackbar: hasSnackbar ?? '');
}

final authController = AuthenticationController();
String changePassMessage = '';
void backbutton(BuildContext context) {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const FrontPage()));
}

void signinbutton(BuildContext context, bool? welcomeMessage) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Navigation(hasSnackbar: 'welcomeMessage')));
}

void forgotpassbutton(BuildContext context) {
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const ForgotPassPage()));
}

class _SignInPageState extends State<SignInPage> {
  final String? hasSnackbar;
  final emailcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  _SignInPageState({required this.hasSnackbar});

  @override
  void dispose() {
    // Dispose of the controller when no longer needed to prevent memory leaks.
    emailcontrol.dispose();
    passwordcontrol.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (hasSnackbar != '') {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        switch (hasSnackbar) {
          case 'changePassSuccess':
            showChangePassSuccessSnackBar();
            break;

          default:
        }
      });
    }
  }

  void showChangePassSuccessSnackBar() {
    String text = 'Password Changed Successfully';
    showSuccessSnackBar(context, text, 'success');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backbutton(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              backbutton(
                  context); // Navigates back to the previous screen (e.g., HomePage)
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: const Text("Sign In"),
          backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        ),
        body: MediaQuery.of(context).orientation == Orientation.portrait
            ? const SignInProcess()
            : ListView(children: const [SignInProcess()]),
      ),
    );

    // return WillPopScope(
    //   onWillPop: () async {
    //     backbutton(context);
    //     return false;
    //   },
    //   child: Scaffold(
    //     resizeToAvoidBottomInset: false,
    //     backgroundColor: const Color.fromARGB(255, 215, 205, 205),
    //     appBar: AppBar(
    //       leading: InkWell(
    //         onTap: () {
    //           backbutton(
    //               context); // Navigates back to the previous screen (e.g., HomePage)
    //         },
    //         child: const Icon(Icons.arrow_back),
    //       ),
    //       title: const Text("Sign In"),
    //       backgroundColor: const Color.fromARGB(255, 215, 205, 205),
    //     ),
    //     body: ListView(children: [SignInProcess()]),
    //   ),
    // );
  }
}
