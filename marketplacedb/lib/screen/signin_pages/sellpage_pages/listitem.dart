import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/constants/constant.dart';
// import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/models/ProductTypeModel.dart';
import 'package:marketplacedb/controllers/variationController.dart';
import 'package:marketplacedb/controllers/productController.dart';

import 'package:marketplacedb/models/VariantsModel.dart';
import 'package:marketplacedb/models/VariantsOptionsModel.dart';
import 'package:marketplacedb/screen/signin_pages/sellpage_pages/categorylist.dart';

final variationController = VariationController();
final productController = Get.put<ProductController>(ProductController());

class Listitempage extends StatefulWidget {
  const Listitempage({
    Key? key,
  }) : super(key: key);

  @override
  State<Listitempage> createState() => ListitempageState();
}

// List<DropdownButton<VariationOptionModel>> createDropdowns(
//     List<VariationModel> variations) {
//   return variations.map((variation) {
//     VariationOptionModel? selectedValue;
//     return DropdownButton<VariationOptionModel>(
//       value: selectedValue, // You can set the initial value here
//       onChanged: (VariationOptionModel? newValue) {
//         selectedValue = newValue;
//         // Handle the selected option for this variation
//       },
//       items: (variation.variation_options ?? []).map((option) {
//         return DropdownMenuItem<VariationOptionModel>(
//           value: option,
//           child: Text(option.value ?? ''),
//         );
//       }).toList(),
//       icon: const Icon(Icons.menu),
//     );
//   }).toList();
// }

class ListitempageState extends State<Listitempage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  VariationOptionModel? variationOptionselected;

  ProductTypeModel? productTypeSelected;
  late List<VariationModel> variations = [];

  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController productTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // variationController.dispose();
    // productTypeController.dispose();
    // descriptionController.dispose();
    // priceController.dispose();
    // _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    final data = await variationController.getVariantsByProductType(
      int.parse(productTypeController.text),
    );
    setState(() {
      variations = data;
    });
    for (var variation in variations) {
      for (var option in variation.variation_options!) {
        print(option);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Center(
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the children horizontally
              children: [
                Text('Listing', style: TextStyle(fontSize: 30)),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.auto_awesome_motion_outlined),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Column(children: [
          Container(
            height: 1, // Adjust the height to make the line thicker
            color: Colors.grey, // Adjust the color as needed
          ),
          const SizedBox(height: 30), //padding
          const Row(children: [
            DashedBorderContainerWithIcon(iconData: Icons.camera_alt),
            DashedBorderContainerWithIcon(iconData: Icons.camera_alt),
            DashedBorderContainerWithIcon(iconData: Icons.camera_alt),
            DashedBorderContainerWithIcon(iconData: Icons.camera_alt),
            DashedBorderContainerWithIcon(iconData: Icons.videocam),
          ]),
          const Sidetext(
            text: 'Read our shooting tips',
            onPressed: null,
            textcolor: Colors.blue,
          ),
          const SizedBox(height: 30),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black, width: 3.0), // Top border
                bottom: BorderSide(
                    color: Colors.black, width: 3.0), // Bottom border
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TabBar(
                controller:
                    _tabController, // You'll need to define _tabController
                tabs: const [
                  Tab(text: 'Info'),
                  Tab(text: 'Attributes'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ExpansiontileButton(
                        text: productTypeSelected?.name ?? "Selected Product",
                        onTap: () {
                          // Add your button's action here
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => const CategoryListPage(),
                            ),
                          )
                              .then((selectedData) async {
                            if (selectedData != null) {
                              setState(() {
                                productTypeController.text =
                                    selectedData.id.toString();
                                productTypeSelected = selectedData;
                                fetchData();
                              });
                              // variations = await variationController
                              //     .getVariantsByProductType(
                              //         int.parse(productTypeController.text));
                              // for (var variation in variations) {
                              //   print(variation.name);
                              // }
                            }
                          });
                        },
                      ),
                      UnderlineTextField(
                        controller: descriptionController,
                        hintText: 'Enter Description',
                        labelText: 'Enter Description',
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                      ),
                      UnderlineTextField(
                        controller: priceController,
                        hintText: 'Item Price',
                        labelText: 'Enter Price',
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Row(children: [
                      LargeWhiteButton(onPressed: null, text: 'Save to Drafts'),
                      LargeBlackButton(
                        onPressed: null,
                        text: 'Post Listing',
                        fontsize: 20,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(horizontal: 0),
                      )
                    ]),
                  ),
                ], // Content for the "Manage" tab
              ),
              ListView(children: [
                if (variations.isNotEmpty)
                  FutureBuilder<List<VariationModel>>(
                    future: variationController.getVariantsByProductType(
                        int.parse(productTypeController.text)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Data is still loading
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 100.0),
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        // An error occurred while loading data
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Data has been loaded
                        List<VariationModel> variations = snapshot.data ?? [];
                        if (variations.isEmpty) {
                          // Variations are empty
                          return Text('No data yet');
                        } else {
                          // Variations are not empty
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 30,
                                horizontal: 20,
                              ),
                              child: Column(
                                children: variations.map((variation) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            variation.name ?? 'asd',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        height: 60,
                                        child: DropdownButton<
                                            VariationOptionModel>(
                                          dropdownColor: Colors.black,
                                          value:
                                              variationOptionselected, // You can set the initial value here
                                          onChanged:
                                              (VariationOptionModel? newValue) {
                                            setState(() {
                                              variationOptionselected =
                                                  newValue;
                                              print(variationOptionselected
                                                  ?.value);
                                            });

                                            // Handle the selected option for this variation
                                          },
                                          items: variation.variation_options
                                              ?.map((option) {
                                            return DropdownMenuItem<
                                                VariationOptionModel>(
                                              value: option,
                                              child: Text(
                                                option.value ?? '',
                                                style: const TextStyle(
                                                  height: 1,
                                                  color: Colors
                                                      .white, // Set the desired text color here
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          icon: const Icon(Icons.menu),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ));
                        }
                      }
                    },
                  )
                else
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'NO PRODUCT TYPE LISTED',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Please select a product type to view additional information',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),

                        // Add your specific widgets for Option 2 here
                      ],
                    ),
                  ),
              ]),
            ]),
          )
        ]));
  }
}
