// ignore_for_file: file_names

import 'package:flutter/material.dart';

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
