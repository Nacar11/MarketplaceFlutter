import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class MPAnimationLoaderWidget extends StatelessWidget {
  const MPAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8),
      const SizedBox(height: MPSizes.defaultSpace),
      Text(text,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center),
      const SizedBox(height: MPSizes.defaultSpace),
      showAction
          ? SizedBox(
              width: 250,
              child: OutlinedButton(
                  onPressed: onActionPressed,
                  child: Text(actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: MPColors.light))))
          : const SizedBox(),
    ]));
  }
}
