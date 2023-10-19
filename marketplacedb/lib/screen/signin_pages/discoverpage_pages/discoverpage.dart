import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/productController.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/screen/signin_pages/discoverpage_pages/see_more.dart';
import 'package:marketplacedb/config/Customappbar.dart';

class CardItem {
  final String urlImage;

  const CardItem({
    required this.urlImage,
  });
}

final controller = Get.put<ProductController>(ProductController());
List<ProductCategoryModel> productCategoryList = controller.productCategoryList;

class Discoverpage extends StatefulWidget {
  const Discoverpage({Key? key}) : super(key: key);

  @override
  State<Discoverpage> createState() => DiscoverpageState();
}

class DiscoverpageState extends State<Discoverpage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {}

  @override
  void dispose() {
    // searchController.dispose();
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomappBar(),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 3, // Adjust the height to make the line thicker
              color: Colors.grey, // Adjust the color as needed
            ),
            Center(
              child: FutureBuilder<List<ProductCategoryModel>>(
                future: controller
                    .getProductCategories(), // Replace with your actual fetch method
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(110.0, 110.0, 110.0, 0.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 4.0, // Adjust the stroke width as needed
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    );
                    // Display a loading indicator
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // Display an error message
                  } else {
                    return Column(
                      children: [
                        for (final category in productCategoryList)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Headertext(
                                        text: category.category_name ?? 'Error',
                                      ),
                                    ),
                                    Sidetext(
                                      text: 'see all',
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Seemore(
                                                    category: category)));
                                      },
                                      textcolor:
                                          Colors.blue, // Set the desired color
                                    ),
                                  ],
                                ),
                              ),
                              const Homepagecon(),
                              const Homepagecon(),
                            ],
                          ),
                      ],
                    );
                  }
                },
              ),
            ),

            FutureBuilder<List<ProductCategoryModel>>(
              future: controller
                  .getProductCategories(), // Replace with your data fetching function
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProductCategoryModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While waiting for the data to load, you can return a loading indicator or message.
                  return Container(); // or any other loading widget.
                } else if (snapshot.hasError) {
                  // Handle the error here.
                  return Text("Error: ${snapshot.error}, No data available");
                } else {
                  // Data has been successfully fetched, build the UI with ExpansionTiles.
                  return Column(
                    children: [
                      for (final category in productCategoryList)
                        ExpansionTile(
                          title: Text(category.category_name ?? "asd"),
                          children: [
                            if (category.children != null)
                              for (final subcategory in category.children!)
                                ListTile(
                                  title: Text(subcategory.category_name ??
                                      "Unnamed Subcategory"),
                                  onTap: () {},
                                ),
                          ],
                        ),
                    ],
                  );
                }
              },
            )
            // Center(
            //     child: Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: DropdownButton(
            //     hint: const Text('Jewelry'),
            //     dropdownColor: Colors.grey,
            //     icon: const Icon(Icons.arrow_drop_down),
            //     iconSize: 36,
            //     isExpanded: true,
            //     style: const TextStyle(
            //       color: Colors.black,
            //       fontSize: 22,
            //     ),
            //     value: valueChoose,
            //     onChanged: (newValue) {
            //       setState(() {
            //         valueChoose = newValue as String;
            //       });
            //     },
            //     items: listItem.map((valueItem) {
            //       return DropdownMenuItem(
            //         value: valueItem,
            //         child: Text(valueItem),
            //       );
            //     }).toList(),
            //   ),
            // )),
          ],
        ),
      ),
    );
  }
}
