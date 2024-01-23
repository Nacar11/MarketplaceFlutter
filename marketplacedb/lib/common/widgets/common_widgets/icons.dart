import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class ShoppingCartCounterIcon extends StatelessWidget {
  const ShoppingCartCounterIcon({
    super.key,
    required this.onPressed,
    required this.iconColor,
  });

  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
          onPressed: () {},
          icon: Icon(Iconsax.shopping_bag,
              color: MPHelperFunctions.isDarkMode(context)
                  ? MPColors.white
                  : MPColors.dark)),
      Positioned(
        right: 0,
        child: Container(
            width: MPSizes.circularBadgeSize,
            height: MPSizes.circularBadgeSize,
            decoration: BoxDecoration(
                color: MPColors.black,
                borderRadius: BorderRadius.circular(
                  MPSizes.circularBadgeSize,
                )),
            child: Center(
                child: Text('2',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: MPColors.white)))),
      )
    ]);
  }
}
