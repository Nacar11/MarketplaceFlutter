import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.selectedAddress,
  });

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {},
      child: MPCircularContainer(
          height: null,
          width: double.infinity,
          showBorder: true,
          padding: const EdgeInsets.all(MPSizes.md),
          backgroundColor: selectedAddress
              ? MPColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? MPColors.darkerGrey
                  : MPColors.grey,
          margin: const EdgeInsets.only(bottom: MPSizes.spaceBtwItems),
          child: Stack(children: [
            Positioned(
              right: 5,
              top: 0,
              child: Icon(selectedAddress ? Iconsax.tick_circle5 : null,
                  color: selectedAddress
                      ? dark
                          ? MPColors.light
                          : MPColors.dark.withOpacity(0.6)
                      : null),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Bran Dale Nacario',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: MPSizes.sm / 2),
              const Text(
                '+6323032122',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: MPSizes.sm / 2),
              const Text('+Gochan Subd, Qiuot, Pardo Cebu', softWrap: true),
            ])
          ])),
    );
  }
}
