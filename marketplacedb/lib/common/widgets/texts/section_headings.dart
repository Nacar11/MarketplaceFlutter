import 'package:flutter/material.dart';

class MPSectionHeading extends StatelessWidget {
  const MPSectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = false,
    required this.title,
    this.buttonTile = 'View All',
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTile;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
      if (showActionButton)
        TextButton(
            onPressed: onPressed,
            child:
                Text(buttonTile, style: Theme.of(context).textTheme.bodyLarge))
    ]);
  }
}
