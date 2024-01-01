// ignore_for_file: avoid_print, unused_import
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/controllers/shoppingCartController.dart';
import 'package:marketplacedb/data/models/ShoppingCartModel.dart';
import 'package:marketplacedb/data/models/ShoppingCartItemModel.dart';
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

void onGooglePayResult(dynamic paymentResult) {
  debugPrint(paymentResult.toString());
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
                        return Column(children: [
                          for (final item in snapshot.data!.items!) ...[
                            const Padding(
                                padding: EdgeInsets.symmetric(
                              vertical: 10,
                            )),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Container(
                                height: 3,
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              children: [
                                // Checkbox on the left side of the image

                                // Image on the left side of the container
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      item.product_item!.product_images?[0]
                                              .product_image ??
                                          'sdf',
                                      width: 120,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                // ID and Price in a column

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.product_item!.product!.name}',
                                    ),
                                    Text(
                                      'Price: P${item.product_item!.price.toString()}',
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          checkoutButton(context, item);
                                        },
                                        style: ButtonStyle(
                                          minimumSize: MaterialStateProperty
                                              .all(const Size(50,
                                                  40)), // Change the width and height as needed
                                        ),
                                        child: const Text(
                                          'Checkout',
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          final response = await controller
                                              .deleteShoppingCartItem(
                                                  item.id!, item.cart_id!);
                                          if (response == true) {
                                            //successsnackbar
                                            setState(() {});
                                            controller.getshoppingcartitem();
                                          }
                                        },
                                        style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    const Size(110, 40))),
                                        child: const Text(
                                          'Delete',
                                        ))
                                  ]),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Container(
                                height: 3,
                                color: Colors.grey,
                              ),
                            ),
                          ]
                        ]);
                      }
                    }),
              ],
            )
          ],
        ));
  }
}
