import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class ExpandedCategoryNameWithCheckIcon extends StatelessWidget {
  const ExpandedCategoryNameWithCheckIcon({
    super.key,
    required this.text,
    required this.textStyle,
  });

  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: textStyle,
          ),
        ),
        const Icon(Iconsax.verify5,
            color: MPColors.secondary, size: MPSizes.iconXs),
      ],
    );
  }
}

class CategoryNameWithCheckIcon extends StatelessWidget {
  const CategoryNameWithCheckIcon({
    super.key,
    required this.text,
    required this.textStyle,
  });

  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: textStyle,
        ),
        const Icon(Iconsax.verify5,
            color: MPColors.secondary, size: MPSizes.iconXs),
      ],
    );
  }
}
