// ignore_for_file: unused_import, file_names, no_logic_in_create_state, avoid_print, use_build_context_synchronously
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/snackbar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/textfields.dart';
import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/controllers/products/ProductItemController.dart';
import 'package:marketplacedb/controllers/shoppingCartController.dart';
import 'package:marketplacedb/data/models/ProductCategoryModel.dart';
import 'package:marketplacedb/data/models/ProductItemModel.dart';
import 'package:marketplacedb/screen/signin_pages/discoverpage_pages/productlistfilter.dart';
import 'package:marketplacedb/screen/signin_pages/navigation.dart';
import 'package:marketplacedb/screen/signin_pages/order_pages/shoppingcart.dart';

final controller = Get.put<ProductItemController>(ProductItemController());
final shoppingcartcontroller = ShoppingCartController();

class SellingPage extends StatefulWidget {
  final ProductItemModel product;

  const SellingPage({Key? key, required this.product}) : super(key: key);

  @override
  State<SellingPage> createState() => SellingPageState(product: product);
}

@override
void dispose() {
  // Dispose of the controller when no longer needed to prevent memory leaks.
}

class SellingPageState extends State<SellingPage> {
  final ProductItemModel product;
  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  SellingPageState({required this.product});

  bool productOwner() {
    final storage = GetStorage();

    if (storage.read('userID') == product.user_id) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.only(
                right: 16,
              ),
              child: Icon(Icons.shopping_bag),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 3,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CarouselSlider(
                items: product.product_images!.map((imageUrl) {
                  return Image.network(
                    imageUrl.product_image!,
                    width: 400,
                    height: 250,
                    fit: BoxFit.cover,
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 250,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                    // Handle page change events here if needed
                  },
                ),
                carouselController: carouselController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: product.product_images!.asMap().entries.map((entry) {
                int index = entry.key;
                return Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('Price: Php ${product.price!.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20)),
            ),

            if (!productOwner())
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Row(children: [
                  LargeWhiteButton(
                    onPressed: () async {
                      print(product.id);
                      print(product.id.runtimeType);
                      final response = await shoppingcartcontroller
                          .addtoCart(product.id!.toString());

                      if (response == 'success') {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              const Navigation(hasSnackbar: 'addedTocart'),
                        ));
                      } else {
                        showErrorHandlingSnackBar(
                          context,
                          'Error Adding to Cart, Please Try Again',
                          'error',
                        );
                      }
                    },
                    text: 'Add to Cart',
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                  ),
                  const LargeWhiteButton(onPressed: null, text: 'Bid/Offer'),
                ]),
              )
            else
              Column(
                children: [
                  const Text(
                    'You are the Owner of this Item',
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: LargeWhiteButton(
                      onPressed: () async {
                        print(product.id!);
                        final response =
                            await controller.deleteListing(product.id!);
                        if (response == true) {
                          productItemController.getProductItemsByProductType(
                              productItemController.productTypeID!);
                          Navigator.of(context).pop(true);
                        }
                      },
                      text: 'Cancel Listing',
                    ),
                  ),
                ],
              )
            // You can display other product details here
          ],
        ));
  }
}

class Product {
  final List<String> imageUrls;
  final double price;

  Product({
    required this.imageUrls,
    required this.price,
    // Initialize other properties here
  });
}
