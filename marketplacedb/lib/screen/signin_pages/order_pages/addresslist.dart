import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/controllers/userController.dart';
import 'package:marketplacedb/data/models/BillingAddressModel.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/billingaddress.dart';

final controller = Get.put<UserController>(UserController());

class Addresslist extends StatelessWidget {
  const Addresslist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 205, 205),
      appBar:
          AppBar(title: const Text(""), backgroundColor: Colors.transparent),
      body: FutureBuilder<List<BillingAddressModel>>(
          future: controller.getAddress(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                strokeWidth: 3.0, // Adjust the stroke width as needed
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue), // Set the desired color
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}'); // Display an error message
            } else if (snapshot.data!.isEmpty) {
              // Display a message when the data is empty
              return const Center(
                child: Text(
                    'No addresses available yet.\n Please add your Billing Address first.'),
              );
            } else {
              return ListView(
                children: [
                  for (final item in snapshot.data!)
                    ListTile(
                        title: Text('${item.address_line_1}, ${item.city}'),
                        leading: const Icon(Icons.home),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.of(context).pop(item);
                        })
                ],
              );
            }
          }),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => const BillingAddress(navigation: 'pop'),
              ))
                  .then((selectedData) async {
                if (selectedData == true) {
                  showSuccessSnackBar(
                      context, 'Billing Address Added', 'success');
                }
              });
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
