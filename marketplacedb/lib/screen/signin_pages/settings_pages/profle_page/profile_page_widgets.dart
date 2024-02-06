import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';

UserController userController = UserController.instance;

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.title,
    required this.value,
    required this.onPressed,
    this.icon = Iconsax.arrow_right_34,
  });
  final String title, value;
  final VoidCallback onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: MPSizes.spaceBtwItems / 1.5),
        child: Row(children: [
          Expanded(
              flex: 3,
              child: Text(title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis)),
          Expanded(
              flex: 5,
              child: Text(value,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis)),
          Expanded(child: Icon(icon, size: 18))
        ]),
      ),
    );
  }
}