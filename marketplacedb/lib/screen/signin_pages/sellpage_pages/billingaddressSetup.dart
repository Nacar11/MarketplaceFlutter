import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:marketplacedb/config/containers.dart';
// import 'package:marketplacedb/config/buttons.dart';
// import 'package:marketplacedb/screen/signin_pages/sellpage_pages/listitem.dart';
// import 'package:marketplacedb/config/textfields.dart';
// import 'package:marketplacedb/controllers/authenticationController.dart';

import 'package:marketplacedb/screen/signin_pages/sellpage_pages/billingaddress.dart';

class BillingAddressSetUp extends StatelessWidget {
  const BillingAddressSetUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        appBar: AppBar(
          title: const Text(""),
          backgroundColor: const Color.fromARGB(255, 215, 205, 205),
        ),
        body: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const BillingAddress(),
            ));
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
            "Set Up your Billing Address",
            style: TextStyle(fontSize: 18),
          ),
        ));
  }
}
