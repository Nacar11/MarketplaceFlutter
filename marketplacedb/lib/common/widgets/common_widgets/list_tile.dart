import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

UserController userController = UserController.instance;

class MPUserProfileTile extends StatelessWidget {
  const MPUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return ListTile(
        title: Text(userController.userData.value.username ?? '',
            style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(userController.userData.value.email ?? '',
            style: Theme.of(context).textTheme.labelLarge),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.edit,
                color: dark ? MPColors.light : MPColors.dark)),
        leading: const MPRoundedImage(
            applyImageRadius: true,
            imageUrl: MPImages.femaleCategoryIcon,
            width: 50,
            height: 50,
            padding: EdgeInsets.all(0)));
  }
}

class MPSettingsMenuTile extends StatelessWidget {
  const MPSettingsMenuTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile();
  }
}
