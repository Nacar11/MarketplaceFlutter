// ignore_for_file: unused_import,, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/config/snackbar.dart';
import 'package:marketplacedb/controllers/OrderLineController.dart';
import 'package:marketplacedb/controllers/products/ProductItemController.dart';
import 'package:marketplacedb/models/OrderLineModel.dart';
import 'package:marketplacedb/models/ProductItemModel.dart';
import 'package:marketplacedb/screen/signin_pages/mepage_pages/mepagesettings.dart';
import 'package:marketplacedb/controllers/userController.dart';
import 'package:marketplacedb/screen/signin_pages/mepage_pages/selling.dart';

final productcontroller =
    Get.put<ProductItemController>(ProductItemController());
final ordercontroller = Get.put<OrderLineController>(OrderLineController());
final storage = GetStorage();

class Mepage extends StatefulWidget {
  const Mepage({Key? key}) : super(key: key);
  @override
  State<Mepage> createState() => MepageState();
}

final userController = UserController();

class MepageState extends State<Mepage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        endDrawer: const Mepagesettings(),
        body: Column(
          children: [
            Container(
              height: 4, // Adjust the height to make the line thicker
              color: Colors.grey, // Adjust the color as needed
            ),

            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                // Add some space on the left
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                  child: CircularProfilePicture(
                    imageAsset: AssetImage('flutter_images/batman.png'),
                  ),
                ),
              ]),
            ), // Add space between profile picture and other content

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: TabBar(
                    controller:
                        _tabController, // You'll need to define _tabController
                    tabs: const [
                      Tab(text: 'Selling'),
                      Tab(text: 'Orders'),
                      Tab(text: 'Saved'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  FirstOptionMenu(),
                  SecondOptionMenu(),
                  Text('Test')
                ],
              ),
            ),
          ],
        ));
  }
}

class CircularProfilePicture extends StatelessWidget {
  final AssetImage imageAsset;

  const CircularProfilePicture({required this.imageAsset, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0, // Adjust the size as needed
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue, // Border color
          width: 2.0, // Border width
        ),
      ),
      child: ClipOval(
        child: Image(image: imageAsset, fit: BoxFit.cover),
      ),
    );
  }
}

class FirstOptionMenu extends StatefulWidget {
  const FirstOptionMenu({Key? key}) : super(key: key);
  @override
  State<FirstOptionMenu> createState() => _FirstOptionMenuState();
}

class _FirstOptionMenuState extends State<FirstOptionMenu> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ordercontroller.isLoading.value == true
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 4 items per row

                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
              ),
              itemCount: productcontroller.productItemListUser.length,
              itemBuilder: (context, index) {
                final item = productcontroller.productItemListUser[index];
                final imageUrl = item.product_images![0].product_image;

                // Add padding around each image

                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      if (imageUrl != null)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SellingPage(
                                        product: item,
                                      )),
                            ).then((selectedData) async {
                              print(selectedData);
                              if (selectedData == true) {
                                showSuccessSnackBar(
                                  context,
                                  'Your Product has been deleted.',
                                  'Success',
                                );
                              }
                            });
                          },
                          child: Image.network(
                            imageUrl,
                            width: 125, // Customize the size as needed
                            height: 125,
                            fit: BoxFit.cover,
                          ),
                        ),

                      // Container(
                      //   width: 120,
                      //   height: 100,
                      //   color: Colors.blue,
                      // )
                    ],
                  ),
                );
              },
            );
    });
  }
}

class SecondOptionMenu extends StatefulWidget {
  const SecondOptionMenu({Key? key}) : super(key: key);
  @override
  State<SecondOptionMenu> createState() => _SecondOptionMenuState();
}

class _SecondOptionMenuState extends State<SecondOptionMenu> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ordercontroller.isLoading.value == true
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 4 items per row

                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
              ),
              itemCount: ordercontroller.orderLineList.length,
              itemBuilder: (context, index) {
                var item = ordercontroller.orderLineList[index];
                final imageUrl = item.product!.product_images?[0].product_image;

                // Add padding around each image

                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        if (imageUrl != null)
                          Image.network(
                            imageUrl,
                            width: 125, // Customize the size as needed
                            height: 125,
                            fit: BoxFit.cover,
                          ),

                        // Container(
                        //   width: 120,
                        //   height: 100,
                        //   color: Colors.blue,
                        // )
                      ],
                    ),
                  ),
                );
              },
            );
    });
  }
}
