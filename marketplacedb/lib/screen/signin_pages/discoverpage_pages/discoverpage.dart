import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/products/ProductController.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/screen/signin_pages/discoverpage_pages/productTypepage.dart';
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
          body: Obx(() {
            return controller.isLoading.value == true
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 4.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  )
                : ListView(
                    children: <Widget>[
                      Container(
                        height: 3, // Adjust the height to make the line thicker
                        color: Colors.grey, // Adjust the color as needed
                      ),
                      Center(
                        child: Column(
                          children: [
                            for (final category in productCategoryList)
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Headertext(
                                            text: category.category_name ??
                                                'Error',
                                          ),
                                        ),
                                        Sidetext(
                                          text: 'see all',
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Seemore(
                                                            category:
                                                                category)));
                                          },
                                          textcolor: Colors
                                              .blue, // Set the desired color
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Homepagecon(),
                                  const Homepagecon(),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Column(
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
                                      onTap: () {
                                        controller.productTypeID =
                                            subcategory.id;
                                        controller.getProductTypeByCategoryId();
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => ProductTypePage(
                                              categoryName:
                                                  subcategory.category_name!),
                                        ));
                                      },
                                    ),
                              ],
                            ),
                        ],
                      )
                    ],
                  );
          })),
    );
  }
}
