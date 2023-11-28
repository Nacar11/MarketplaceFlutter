import 'package:flutter/material.dart';
import 'package:marketplacedb/controllers/userController.dart';
import 'package:get/get.dart';

final controller = Get.put<UserController>(UserController());

// List<ProductCategoryModel> productCategoryList = controller.productCategoryList;

class ListOfCountryPage extends StatelessWidget {
  const ListOfCountryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Country Code',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Obx(() {
        return controller.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : ListView(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          for (final country in controller.countryList)
                            ListTile(
                              title: Text(country.name ??
                                  "Error API Response Handling"),
                              onTap: () {
                                Navigator.of(context).pop(country);
                              },
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ]);
      }),
    );
  }
}
