import 'package:get/get.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/common/widgets/layouts/grid_layout.dart';
import 'package:marketplacedb/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:marketplacedb/common/widgets/shimmer/shimmer_progress.dart';
import 'package:marketplacedb/common/widgets/texts/text_with_icons.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/data/models/ProductCategoryModel.dart';
import 'package:marketplacedb/data/models/ProductItemModel.dart';
import 'package:marketplacedb/data/models/ProductTypeModel.dart';
import 'package:marketplacedb/screen/signin_pages/discover_pages/product_types_page/product_types_controller.dart';

import 'package:flutter/material.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/device/device_utility.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

final productTypesPageController = Get.put(ProductTypesPageController());
ProductItemController productItemController = ProductItemController.instance;

class MPTabBarProductTypes extends StatelessWidget
    implements PreferredSizeWidget {
  const MPTabBarProductTypes({
    super.key,
    required this.tabs,
    required this.onTabPressed,
    required this.productTypes,
  });

  final List<Widget> tabs;
  final Function(int, ProductTypeModel) onTabPressed;
  final List<ProductTypeModel> productTypes;
  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return Material(
        color: dark ? MPColors.black : MPColors.white,
        child: TabBar(
          tabs: tabs,
          onTap: (index) {
            onTabPressed(index, productTypes[index]);
          },
          isScrollable: true,
          indicatorColor: MPColors.primary,
          labelColor: dark ? MPColors.white : MPColors.primary,
          unselectedLabelColor: MPColors.darkGrey,
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(MPDeviceUtils.getAppBarHeight());
}

class MPTabBarViewProductTypes extends StatelessWidget {
  const MPTabBarViewProductTypes({
    super.key,
    required this.productItemController,
  });

  final ProductItemController productItemController;

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
              padding: const EdgeInsets.all(MPSizes.md),
              child: Column(children: [
                Obx(
                  () => SizedBox(
                    child: Center(
                      child: productItemController.isLoading.value
                          ? MPGridLayout(
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return const ShimmerProgressContainer(
                                    height: 250);
                              },
                            )
                          : productItemController
                                  .productItemListByProductType.isEmpty
                              ? const Text('NO ITEM LISTED YET')
                              : MPGridLayout(
                                  itemCount: productItemController
                                      .productItemListByProductType.length,
                                  itemBuilder: (context, index) {
                                    ProductItemModel productItem =
                                        productItemController
                                                .productItemListByProductType[
                                            index];
                                    return MPProductCardVertical(
                                        productItemData: productItem);
                                  },
                                ),
                    ),
                  ),
                ),
              ])),
        ]);
  }
}

class MPClickableCircularContainer extends StatefulWidget {
  const MPClickableCircularContainer({
    Key? key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = MPSizes.cardRadiusLg,
    this.margin,
    this.padding,
    this.borderColor = MPColors.borderPrimary,
    this.backgroundColor = Colors.white,
    this.onClicked,
    required this.index,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double radius;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback? onClicked;
  final int index;

  @override
  MPCircularContainerState createState() => MPCircularContainerState();
}

class MPCircularContainerState extends State<MPClickableCircularContainer> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool isClicked = widget.index ==
            productTypesPageController.currentClickedSubcategory.value;

        return GestureDetector(
          onTap: () {
            if (widget.onClicked != null) {
              widget.onClicked!();
            }

            productTypesPageController.updatePageIndicator(widget.index);
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            margin: widget.margin,
            padding: widget.padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              border: isClicked ? Border.all(color: Colors.blue) : null,
              color: widget.backgroundColor,
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class ClickableCategoryCard extends StatelessWidget {
  const ClickableCategoryCard({
    super.key,
    required this.productCategory,
    required this.index,
  });

  final ProductCategoryModel productCategory;
  final int index;

  @override
  Widget build(BuildContext context) {
    return MPClickableCircularContainer(
        index: index,
        onClicked: () async {
          await productTypesPageController.updatePageIndicator(index);
          await productController
              .getProductTypesByCategoryId(productCategory.id!);
          await productItemController.getProductItemsByProductType(
              productController.productTypes[0].id!);
        },
        borderColor: MPHelperFunctions.isDarkMode(context)
            ? MPColors.white
            : MPColors.dark,
        padding: const EdgeInsets.all(MPSizes.sm),
        backgroundColor: Colors.transparent,
        child: Row(children: [
          Flexible(
            child: MPRoundedImage(
                width: 40,
                height: 50,
                isNetworkImage: true,
                imageUrl: productCategory.product_image!),
          ),
          const SizedBox(width: MPSizes.spaceBtwItems),
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandedCategoryNameWithCheckIcon(
                    textStyle: Theme.of(context).textTheme.labelLarge!,
                    text: productCategory.category_name!,
                  ),
                  Text('256 Products ',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium)
                ]),
          )
        ]));
  }
}

// class MPCategoryCard extends StatelessWidget {
//   const MPCategoryCard({
//     super.key,
//     required this.productCategory,
//   });

//   final ProductCategoryModel productCategory;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: MPCircularContainer(
//           borderColor: MPHelperFunctions.isDarkMode(context)
//               ? MPColors.white
//               : MPColors.dark,
//           padding: const EdgeInsets.all(MPSizes.sm),
//           backgroundColor: Colors.transparent,
//           child: Row(children: [
//             Flexible(
//               child: MPRoundedImage(
//                   width: 40,
//                   height: 50,
//                   isNetworkImage: true,
//                   imageUrl: productCategory.product_image!),
//             ),
//             const SizedBox(width: MPSizes.spaceBtwItems),
//             Expanded(
//               child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CategoryNameWithCheckIcon(
//                         textStyle: Theme.of(context).textTheme.labelLarge!,
//                         text: productCategory.category_name!),
//                     Text('256 Products ',
//                         overflow: TextOverflow.ellipsis,
//                         style: Theme.of(context).textTheme.labelMedium)
//                   ]),
//             )
//           ])),
//     );
//   }
// }
