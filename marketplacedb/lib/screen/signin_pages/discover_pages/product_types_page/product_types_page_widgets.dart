import 'package:get/get.dart';
import 'package:marketplacedb/screen/signin_pages/discover_pages/product_types_page/product_types_controller.dart';

import 'package:flutter/material.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

final productTypesPageController = Get.put(ProductTypesPageController());

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
