// ignore_for_file: unused_import, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';

class CustomSnackBar extends StatefulWidget {
  final String message;
  const CustomSnackBar({Key? key, required this.message}) : super(key: key);

  @override
  State<CustomSnackBar> createState() => CustomSnackBarState(message: message);
}

class CustomSnackBarState extends State<CustomSnackBar> {
  final String message;

  CustomSnackBarState({required this.message});
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {},
      ),
    );
  }
}

void showSuccessSnackBar(BuildContext context, String message, String type) {
  Flushbar(
    margin: const EdgeInsets.all(15),
    duration: const Duration(seconds: 1),
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    backgroundGradient: LinearGradient(
      colors: [Colors.green.shade800, Colors.greenAccent.shade700],
      stops: const [0.6, 1],
    ),
    boxShadows: const [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: type == 'loginsuccess' ? 'Successfully Logged In' : 'Success',
  ).show(context);
}

void socialLoginSignUp(BuildContext context, String message, String type) {
  Flushbar(
    margin: const EdgeInsets.all(15),
    duration: const Duration(seconds: 3),
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    backgroundGradient: LinearGradient(
      colors: [Colors.green.shade800, Colors.greenAccent.shade700],
      stops: const [0.6, 1],
    ),
    boxShadows: const [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: type == 'loginsuccess' ? 'Welcome!' : 'Success',
  ).show(context);
}

void showErrorHandlingSnackBar(
    BuildContext context, String message, String type) {
  Flushbar(
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 1),
          message: message,
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          backgroundGradient: LinearGradient(
            colors: [Colors.red.shade800, Colors.redAccent.shade700],
            stops: const [0.6, 1],
          ),
          boxShadows: const [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 3,
            ),
          ],
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          title: 'Error')
      .show(context);
}
