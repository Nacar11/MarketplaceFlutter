// ignore_for_file: unused_import, file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/containers.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/config/Customappbar.dart';
import 'package:marketplacedb/controllers/productController.dart';
import 'package:marketplacedb/models/ProductCategoryModel.dart';
import 'package:marketplacedb/models/ProductItemModel.dart';

final controller = Get.put<ProductController>(ProductController());

class ProductItemPage extends StatefulWidget {
  final Product product;

  const ProductItemPage({Key? key, required this.product}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ProductItemPage> createState() => ProductItemPageState(
        product: product,
      );
}

@override
void dispose() {
  // Dispose of the controller when no longer needed to prevent memory leaks.
}

class ProductItemPageState extends State<ProductItemPage> {
  final Product product;
  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  ProductItemPageState({required this.product});

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
                items: product.imageUrls.map((imageUrl) {
                  return Image.network(
                    imageUrl,
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
              children: product.imageUrls.asMap().entries.map((entry) {
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
              child: Text('Price: Php ${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20)),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Row(children: [
                LargeWhiteButton(
                  onPressed: null,
                  text: 'Add to Cart',
                  margin: EdgeInsets.symmetric(horizontal: 35),
                ),
                LargeWhiteButton(onPressed: null, text: 'Bid/Offer'),
              ]),
            ),
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