import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/images.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/profle_page/profile_page.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';

UserController userController = UserController.instance;

class MPUserProfileTile extends StatelessWidget {
  const MPUserProfileTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    final dark = MPHelperFunctions.isDarkMode(context);
    return ListTile(
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.labelLarge),
        trailing: IconButton(
            onPressed: () {
              Get.to(() => const ProfilePage());
            },
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
  const MPSettingsMenuTile({
    Key? key,
    this.icon,
    required this.title,
    this.subTitle, // Update the type to String?
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final IconData? icon;
  final String title;
  final String? subTitle; // Update the type to String?
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          icon != null ? Icon(icon, size: 28, color: MPColors.primary) : null,
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: subTitle != null
          ? Text(subTitle!, style: Theme.of(context).textTheme.labelMedium)
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
