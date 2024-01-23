import 'package:flutter/material.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProgressContainer extends StatelessWidget {
  const ShimmerProgressContainer({
    Key? key,
    this.height = 180,
    this.circular = false,
    this.width,
  }) : super(key: key);

  final double height;
  final bool circular;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: circular
                  ? BorderRadius.circular(height / 2)
                  : BorderRadius.circular(MPSizes.cardRadiusLg),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
