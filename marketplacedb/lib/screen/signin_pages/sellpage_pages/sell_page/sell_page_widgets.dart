import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';

class MPSellPageAppBar extends StatelessWidget {
  const MPSellPageAppBar({
    super.key,
    required this.showBackArrow,
  });

  final bool showBackArrow;

  @override
  Widget build(BuildContext context) {
    return PrimarySearchAppBar(
      showBackArrow: showBackArrow,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Sell ", style: Theme.of(context).textTheme.headlineMedium),
      ]),
      actions: [
        ShoppingCartCounterIcon(
          onPressed: () {},
        )
      ],
    );
  }
}
