// ignore_for_file: no_logic_in_create_state, unused_import, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/controllers/OrderLineController.dart';
import 'package:marketplacedb/controllers/paymentMethodController.dart';
import 'package:marketplacedb/controllers/shippingController.dart';
import 'package:marketplacedb/controllers/shoppingCartController.dart';
import 'package:marketplacedb/data/models/BillingAddressModel.dart';
import 'package:marketplacedb/data/models/PaymentMethodModel.dart';
import 'package:marketplacedb/data/models/ShippingMethodModel.dart';
import 'package:marketplacedb/data/models/ShoppingCartItemModel.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/screen/signin_pages/order_pages/addresslist.dart';
import 'package:marketplacedb/screen/signin_pages/order_pages/methodlist.dart';
import 'package:marketplacedb/screen/signin_pages/order_pages/paymentoption.dart';
import 'package:url_launcher/url_launcher.dart';

final OrderLineController order_controller =
    Get.put<OrderLineController>(OrderLineController());

final PaymentMethodController payment_method_controller =
    Get.put<PaymentMethodController>(PaymentMethodController());

final shipping_payment_controller =
    Get.put<ShippingController>(ShippingController());

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
  String? selectedPaymentMethod;

  CheckoutPageState({required this.item});
  final shipping = TextEditingController();
  String selectedPaymentType = 'Gcash';

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
                  const EdgeInsets.all(5), // Adjust the padding as needed
              title: const Text(
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
                child: const Center(
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
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius to change the roundness
                    child: Image.network(
                      item.product_item!.product_images?[0].product_image ??
                          'asd',
                      width: 120,
                      height: 120,
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
            FutureBuilder<List<ShippingMethodModel>>(
              future: shipping_payment_controller
                  .getShippingMethods(), // Assuming _fetchShippingMethods returns a Future<List<ShippingMethodModel>>
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No shipping methods available.'),
                  );
                } else {
                  // Use the first shipping method as the default if none is selected

                  return Column(
                    children: [
                      Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(15),
                        title: const Text(
                          'Shipping Method',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        trailing: shippingmethod == null
                            ? Text('P${snapshot.data?[0].price}')
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
                          padding: const EdgeInsets.all(0),
                          child: shippingmethod == null
                              ? Text('${snapshot.data?[0].name}')
                              : Text(
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
                    ],
                  );
                }
              },
            ),
            InkWell(
              onTap: () async {
                await Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => const PaymentOption()))
                    .then((selectedData) async {
                  if (selectedData != null) {
                    setState(() {
                      selectedPaymentMethod = selectedData;
                    });
                  }
                });
              },
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Headertext(text: 'Payment option'),
                    Text(
                      selectedPaymentMethod ?? 'Select a payment method',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_outlined),
              ),
            ),
            Container(
              height: 2,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LargeWhiteButton(
                      onPressed: () async {
                        GetStorage storage = GetStorage();
                        var data = {
                          'currency': 'PHP',
                          "name":
                              ('${storage.read('first_name')} ${storage.read('last_name')}'),
                          "email": storage.read('email'),
                          "phone": storage.read('contact_number'),
                          "amount": item.product_item!.price.toString()
                        };
                        var response = await payment_method_controller
                            .paymentRequest(data);
                        if (response is String) {
                          Uri uri = Uri.parse(response);

                          await launchUrl(uri, mode: LaunchMode.inAppWebView);
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
