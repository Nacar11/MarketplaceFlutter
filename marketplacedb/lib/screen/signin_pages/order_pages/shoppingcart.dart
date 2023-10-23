// ignore_for_file: avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/controllers/shoppingCartController.dart';
import 'package:marketplacedb/models/ShoppingCartModel.dart';
import 'package:marketplacedb/models/shoppingCartItemModel.dart';
import 'package:marketplacedb/screen/signin_pages/order_pages/checkout.dart';

final controller = Get.put<ShoppingCartController>(ShoppingCartController());

class Shoppingcart extends StatefulWidget {
  const Shoppingcart({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Shoppingcart> createState() => ShoppingcartState();
}

void checkoutButton(BuildContext context, ShoppingCartItemModel item) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => CheckoutPage(item: item)));
}

class ShoppingcartState extends State<Shoppingcart> {
  Map<int, bool> itemCheckedState = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Bag',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 3,
                    color: Colors.grey,
                  ),
                ),
                FutureBuilder<ShoppingCartModel?>(
                  future: controller.getshoppingcartitem(),
                  // Replace with your actual fetch method
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Display a loading indicator
                    } else if (snapshot.hasError) {
                      return Text(
                          'Error: ${snapshot.error}'); // Display an error message
                    } else {
                      return Column(
                        children: [
                          for (final item in snapshot.data!.items!) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Container(
                                width: 400,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    print(item);
                                    // Handle the click action
                                  },
                                  child: Row(
                                    children: [
                                      // Checkbox on the left side of the image
                                      Checkbox(
                                        value:
                                            itemCheckedState[item.id] ?? false,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            itemCheckedState[item.id!] =
                                                value ?? false;
                                          });
                                        },
                                      ),
                                      // Image on the left side of the container
                                      Image.network(
                                        item.product_item!.product_images?[0]
                                                .product_image ??
                                            'sdf',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      // ID and Price in a column
                                      Padding(
                                        padding: const EdgeInsets.only(top: 50),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('ID: ${item.id.toString()}'),
                                            Text(
                                                'Price: ${item.product_item!.price.toString()}'),
                                          ],
                                        ),
                                      ),
                                      // ElevatedButton on the right side
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            checkoutButton(context, item);
                                          },
                                          child: const Text('Checkout'),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: null,
                                          child: const Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ));
  }
}
