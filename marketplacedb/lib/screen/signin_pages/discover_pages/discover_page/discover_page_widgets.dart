import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/common_widgets/app_bars.dart';
import 'package:marketplacedb/common/widgets/common_widgets/icons.dart';

class MPDiscoverAppBar extends StatelessWidget {
  const MPDiscoverAppBar({
    super.key,
    required this.showBackArrow,
  });

  final bool showBackArrow;

  @override
  Widget build(BuildContext context) {
    return PrimarySearchAppBar(
      showBackArrow: showBackArrow,
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Discover", style: Theme.of(context).textTheme.headlineMedium),
      ]),
      actions: [
        ShoppingCartCounterIcon(
          onPressed: () {},
        )
      ],
    );
  }
}


// class MPDiscoverAppBar extends StatelessWidget {
//   const MPDiscoverAppBar({
//     super.key,
//     required this.showBackArrow,
//     required this.text,
//   });

//   final bool showBackArrow;
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: MPSizes.xs),
//       child: Padding(
//         padding: const EdgeInsets.only(right: MPSizes.md),
//         child: PrimarySearchAppBar(
//           showBackArrow: showBackArrow,
//           title:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(text, style: Theme.of(context).textTheme.headlineMedium),
//           ]),
//           actions: [
//             ShoppingCartCounterIcon(
//               onPressed: () {},
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
