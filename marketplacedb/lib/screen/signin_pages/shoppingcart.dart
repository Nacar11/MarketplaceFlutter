import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/controllers/shoppingCartController.dart';
import 'package:marketplacedb/models/ShoppingCartModel.dart';

final controller = Get.put<ShoppingCartController>(ShoppingCartController());

class Shoppingcart extends StatefulWidget {
  const Shoppingcart({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Shoppingcart> createState() => ShoppingcartState();
}

class ShoppingcartState extends State<Shoppingcart> {
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
                FutureBuilder<ShoppingCartModel>(
                  future: controller
                      .getshoppingcartitem(), // Replace with your actual fetch method
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Display a loading indicator
                    } else if (snapshot.hasError) {
                      return Text(
                          'Error: ${snapshot.error}'); // Display an error message
                    } else {
                      return Column(
                        children: [
                          for (final item
                              in snapshot.data!.shopping_cart_items ?? [])
                            InkWell(
                              onTap: () {
                                print(item.id);

                                // Handle the click action
                              },
                              child: ListTile(
                                title: Text(item.category_name ??
                                    "Error on Handling API Responses"),
                              ),
                            )
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
