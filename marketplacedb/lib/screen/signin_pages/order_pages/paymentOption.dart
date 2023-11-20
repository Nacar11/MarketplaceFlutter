import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/shippingController.dart';
import 'package:marketplacedb/models/ShippingMethodModel.dart';

final controller = Get.put<ShippingController>(ShippingController());
String? paymentOption;

class PaymentOption extends StatelessWidget {
  const PaymentOption({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(
            'Payment Option',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent),
      body: Column(children: [
        ListTile(
          onTap: () {
            paymentOption = 'Gcash';
            Navigator.of(context).pop(paymentOption);
          },
          title: const Text('Gcash'),
        ),
        const ExpansionTile(
            title: Text('Debit Card/ Credit Card'),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add New Debit Card/ Credit Card'),
              ),
            ])
      ]),
    );
  }
}
