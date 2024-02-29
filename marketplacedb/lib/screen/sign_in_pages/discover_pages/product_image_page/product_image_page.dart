import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/screen/sign_in_pages/discover_pages/product_item_page/product_item_page_controller.dart';

class ProductImagePage extends StatelessWidget {
  const ProductImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductItemPageController productItemPageController =
        ProductItemPageController.instance;
    return SafeArea(
        child: Scaffold(
            appBar: const PrimarySearchAppBar(),
            body: MPCircularContainer(
                child: MPRoundedImage(
              imageUrl: productItemPageController.singleProductImage.value,
              isNetworkImage: true,
            ))));
  }
}
