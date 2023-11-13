// ignore_for_file: no_logic_in_create_state, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/OrderLineController.dart';
import 'package:marketplacedb/controllers/paymentMethodController.dart';
import 'package:marketplacedb/controllers/shoppingCartController.dart';
import 'package:marketplacedb/models/BillingAddressModel.dart';
import 'package:marketplacedb/models/PaymentMethodModel.dart';
import 'package:marketplacedb/models/ShippingmethodModel.dart';
import 'package:marketplacedb/models/ShoppingCartItemModel.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/screen/signin_pages/order_pages/addresslist.dart';
import 'package:marketplacedb/screen/signin_pages/order_pages/methodlist.dart';
import 'package:url_launcher/url_launcher.dart';

final OrderLineController order_controller =
    Get.put<OrderLineController>(OrderLineController());

final PaymentMethodController payment_method_controller =
    Get.put<PaymentMethodController>(PaymentMethodController());

class CheckoutPage extends StatefulWidget {
  final ShoppingCartItemModel item;

  const CheckoutPage({Key? key, required this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CheckoutPageState(item: item);
}

class CheckoutPageState extends State<CheckoutPage> {
  final ShoppingCartItemModel item;
  PaymentMethodModel? paymentmethod;
  BillingAddressModel? selectedAddress;
  ShippingMethodModel? shippingmethod;

  CheckoutPageState({required this.item});
  final shipping = TextEditingController();
  String selectedPaymentType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(children: [
        Column(
          children: <Widget>[
            Container(
              height: 3,
              color: Colors.grey,
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.all(15), // Adjust the padding as needed
              title: Text(
                'Shipping Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              trailing: Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.brown,
                ),
                child: Center(
                  child: Text(
                    'OTHER',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () async {
                final selectedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Addresslist(),
                  ),
                );
                if (selectedData != null) {
                  setState(() {
                    selectedAddress = selectedData;
                  });
                }
              },
              subtitle: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  selectedAddress != null
                      ? '${selectedAddress!.address_line_1},\n ${selectedAddress!.city}'
                      : 'Select Your Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 2,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Image.network(
                      item.product_item!.product_images?[0].product_image ??
                          'asd',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Price: Php ${item.product_item!.price?.toStringAsFixed(2) ?? 'N/A'}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
              height: 2,
              color: Colors.grey,
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.all(15), // Adjust the padding as needed
              title: const Text(
                'Shipping Method',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              trailing: shippingmethod == null
                  ? const Text('')
                  : Text('P${shippingmethod?.price}'),
              onTap: () async {
                final selectedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Methodlist(),
                  ),
                );
                if (selectedData != null) {
                  setState(() {
                    shippingmethod = selectedData;
                  });
                }
              },
              subtitle: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '${shippingmethod?.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 2,
              color: Colors.grey,
            ),
            const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Headertext(text: 'Payment Type'))
                ])),
            Column(
              children: <Widget>[
                RadioListTile(
                  title: const Text('Paypal'),
                  value: 'Paypal',
                  groupValue: selectedPaymentType,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentType = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Gcash'),
                  value: 'Gcash',
                  groupValue: selectedPaymentType,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentType = value!;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LargeWhiteButton(
                      onPressed: () async {
                        var data = {
                          'currency': 'PHP',
                          "amount": item.product_item!.price.toString()
                        };
                        var response = await payment_method_controller
                            .paymentRequest(data);
                        if (response is String) {
                          Uri uri =
                              Uri.parse(response); // Convert String to Uri
                          await launchUrl(uri);
                        } else {
                          // Handle the case where the response is not a valid URL
                          print('Invalid URL or unable to launch the URL');
                        }
                      },
                      text: 'Check Out',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
