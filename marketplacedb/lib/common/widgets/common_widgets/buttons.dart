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
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MPSizes.buttonHeight,
      margin: const EdgeInsets.symmetric(vertical: MPSizes.xs),
      child: MPPrimaryButton(
        icon: const Icon(Iconsax.transaction_minus5, color: MPColors.white),
        text: text,
        onPressed: () {},
      ),
    );
  }
}

class MPCustomOutlinedButton extends StatelessWidget {
  const MPCustomOutlinedButton({
    Key? key,
    required this.text,
    this.icon,
    required this.onPressed,
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
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall!,
          ),
        ],
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  final Function()? onTap;

  const GoogleButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define responsive values based on screen size

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius:
              BorderRadius.circular(10), // Adjust the radius value as needed
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: 24,
              height: 24,
              image: AssetImage('assets/images/googleIcon.png'),
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10), // Adjust the space between icon and text
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Continue with Google",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FBButton extends StatelessWidget {
  final Function()? onTap;

  const FBButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: const Color(0xFF1877F2),
          borderRadius:
              BorderRadius.circular(10), // Adjust the radius value as needed
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.facebook, // Replace this with your desired Facebook icon
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 10), // Adjust the space between icon and text
            Text(
              "Continue with Facebook",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
