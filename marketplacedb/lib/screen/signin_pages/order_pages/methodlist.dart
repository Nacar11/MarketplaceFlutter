import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/controllers/shippingController.dart';
import 'package:marketplacedb/models/ShippingmethodModel.dart';

final controller = Get.put<ShippingController>(ShippingController());

class Methodlist extends StatelessWidget {
  const Methodlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      appBar:
          AppBar(title: const Text(""), backgroundColor: Colors.transparent),
      // body: FutureBuilder<List<ShippingMethodModel>>(
      //     future: controller.getShippingMethods(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return const CircularProgressIndicator(
      //           strokeWidth: 3.0, // Adjust the stroke width as needed
      //           valueColor: AlwaysStoppedAnimation<Color>(
      //               Colors.blue), // Set the desired color
      //         );
      //       } else if (snapshot.hasError) {
      //         return Text('${snapshot.error}'); // Display an error message
      //       } else if (snapshot.data!.isEmpty) {
      //         // Display a message when the data is empty
      //         return const Center(
      //           child: Text(
      //               'No addresses available yet.\n Please add your Billing Address first.'),
      //         );
      //       } else {
      //         return ListView(
      //           children: [
      //             for (final item in snapshot.data!)
      //               ListTile(
      //                   title: Text('${item.name}, ${item.price}'),
      //                   leading: const Icon(Icons.home),
      //                   trailing: const Icon(Icons.arrow_forward),
      //                   onTap: () {
      //                     Navigator.of(context).pop(item);
      //                   })
      //           ],
      //         );
      //       }
      //     }),
    );
  }
}
