// ignore_for_file: file_names

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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar:
          AppBar(title: const Text(""), backgroundColor: Colors.transparent),
      body: Stack(
        children: <Widget>[
          // Background Image
          const Positioned.fill(
            child: AspectRatio(
              aspectRatio: 10 / 5, // You can adjust the aspect ratio as needed
              child: Image(
                image: AssetImage('flutter_images/billing.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Positioned(
              bottom: 430,
              left: 20,
              child: Text(
                'Start Selling your Items in \nUkayco.Ph',
                style: TextStyle(fontSize: 20),
              )),
          Positioned(
            bottom: 360,
            left: 10,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BillingAddress(),
                ));
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                "Set Up your Billing Address",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
