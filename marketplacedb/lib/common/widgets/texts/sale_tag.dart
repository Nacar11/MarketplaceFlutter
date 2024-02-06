import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class MPSaleTag extends StatelessWidget {
  const MPSaleTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MPCircularContainer(
        height: 25,
        width: 40,
        radius: MPSizes.sm,
        backgroundColor: MPColors.sale.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(
            horizontal: MPSizes.sm, vertical: MPSizes.xs),
        child: Text('25%',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .apply(color: MPColors.black)));
  }
}
