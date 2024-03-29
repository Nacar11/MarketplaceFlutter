import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

class MPPrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final bool isDisabled;
  final String text;
  final bool isLoading;
  final Icon? icon;

  const MPPrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isDisabled = false,
    this.isLoading = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled || isLoading
            ? MPColors.buttonDisabled
            : MPColors.buttonPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(MPSizes.borderRadiusMd)),
        ),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: MPSizes.iconMd,
                height: MPSizes.iconMd,
                child: CircularProgressIndicator(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: MPSizes.xs),
                  ],
                  Text(text,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                ],
              ),
      ),
    );
  }
}

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({
    Key? key,
    this.isDisabled = false,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final bool isDisabled;
  final String text;
  final Future Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MPSizes.buttonHeight,
      margin: const EdgeInsets.symmetric(vertical: MPSizes.xs),
      child: MPPrimaryButton(
          isDisabled: isDisabled,
          icon: const Icon(Iconsax.transaction_minus5, color: MPColors.white),
          text: text,
          onPressed: onPressed),
    );
  }
}

class MPOutlinedButton extends StatelessWidget {
  const MPOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  final String text;
  final Future Function() onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: MPSizes.xs),
          ],
          Text(text, style: Theme.of(context).textTheme.bodyLarge!),
        ],
      ),
    );
  }
}
