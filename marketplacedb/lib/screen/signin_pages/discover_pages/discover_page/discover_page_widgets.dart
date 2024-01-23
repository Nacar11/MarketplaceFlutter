import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/CustomAppBar.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class MPDiscoverAppBar extends StatelessWidget {
  const MPDiscoverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PrimarySearchAppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: MPSizes.lg),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Store", style: Theme.of(context).textTheme.headlineMedium),
        ]),
      ),
      showBackArrow: false,
      actions: [
        ShoppingCartCounterIcon(onPressed: () {}, iconColor: MPColors.white)
      ],
    );
  }
}
