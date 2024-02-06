import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/texts/peso_sign.dart';

class MPProductPriceText extends StatelessWidget {
  const MPProductPriceText({
    super.key,
    required this.price,
    this.isLarge = false,
    this.maxLines = 1,
    this.lineThrough = false,
  });

  final String price;
  final bool isLarge;
  final int maxLines;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const PesoSign(),
      Text(price,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: isLarge
              ? Theme.of(context).textTheme.headlineSmall!.apply(
                  decoration: lineThrough ? TextDecoration.lineThrough : null)
              : Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: lineThrough ? TextDecoration.lineThrough : null)),
    ]);
  }
}
