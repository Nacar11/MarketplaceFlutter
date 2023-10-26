import 'package:flutter/material.dart';
import 'package:marketplacedb/controllers/userController.dart';
import 'package:marketplacedb/models/CountryModel.dart';
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
      body: ListView(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            FutureBuilder<List<CountryModel>>(
              future: controller
                  .getCountries(), // Replace with your actual fetch method
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Display a loading indicator
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Display an error message
                } else {
                  List<CountryModel> countryList = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final country in countryList)
                          ListTile(
                            title: Text(
                                country.name ?? "Error API Response Handling"),
                            onTap: () {
                              Navigator.of(context).pop(country);
                            },
                          ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ]),
    );
  }
}
