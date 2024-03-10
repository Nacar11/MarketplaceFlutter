import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/buttons.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/common/widgets/common_widgets/list_tile.dart';
import 'package:marketplacedb/common/widgets/texts/section_headings.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/account_settings_page/account_settings_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/account_settings_page/account_settings_page_widgets.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/address_list_page/address_list_page.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/shopping_cart_page/shopping_cart_page.dart';
import 'package:marketplacedb/screen/sign_in_pages/settings_pages/orders_list_page/orders_list_page.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/theme/theme.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountSettingsPageController =
        Get.put(AccountSettingsPageController());
    UserController userController = UserController.instance;
    return Obx(() => accountSettingsPageController.isLoading.value
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  MPPrimaryHeaderContainer(
                    child: Column(
                      children: [
                        const MPSettingsAppBar(),
                        MPUserProfileTile(
                          title: userController.userData.value.username ?? '',
                          subtitle: userController.userData.value.email ?? '',
                        ),
                        const SizedBox(height: MPSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(MPSizes.md),
                    child: Column(
                      children: [
                        const MPSectionHeading(title: "Account Settings"),
                        const SizedBox(height: MPSizes.spaceBtwItems),
                        MPSettingsMenuTile(
                          icon: Iconsax.safe_home,
                          title: "My Addresses",
                          subTitle: "Set home address for delivery",
                          onTap: () => Get.to(() => const AddressListPage()),
                        ),
                        MPSettingsMenuTile(
                          icon: Iconsax.shopping_cart,
                          title: "My Cart",
                          subTitle: "Add, remove or move items to checkout",
                          onTap: () => Get.to(() => const ShoppingCartPage()),
                        ),
                        MPSettingsMenuTile(
                          icon: Iconsax.bag_tick,
                          title: "My Orders",
                          subTitle: "Track your orders",
                          onTap: () => Get.to(() => const OrdersListPage()),
                        ),
                        MPSettingsMenuTile(
                          icon: Iconsax.forward_item,
                          title: "My Listed Items",
                          subTitle: "Check your items listed to Marketplace",
                          onTap: () {},
                        ),
                        MPSettingsMenuTile(
                          icon: Iconsax.bank,
                          title: "Bank Account",
                          subTitle: "Link your bank account to Marketplace",
                          onTap: () {},
                        ),
                        MPSettingsMenuTile(
                          icon: Iconsax.discount_shape,
                          title: "My Coupons",
                          subTitle: "Redeem your coupons to avail discounts",
                          onTap: () {},
                        ),
                        MPSettingsMenuTile(
                          icon: Iconsax.notification,
                          title: "Notifications",
                          subTitle:
                              "Set up your notifications whenever your items get sold",
                          onTap: () {},
                        ),
                        MPSettingsMenuTile(
                          icon: Iconsax.security_card,
                          title: "Account Privacy",
                          subTitle: "Manage data usage and connected accounts",
                          onTap: () {},
                        ),
                        const SizedBox(height: MPSizes.spaceBtwSections),
                        const MPSectionHeading(title: "Application Settings"),
                        const SizedBox(height: MPSizes.spaceBtwItems),
                        MPSettingsMenuTile(
                          icon: Iconsax.document_upload,
                          title: "Load Data",
                          subTitle: "Upload data to cloud",
                          onTap: () {},
                        ),
                        MPSettingsMenuTile(
                          icon: Iconsax.security_user,
                          title: "Geolocation",
                          subTitle: "Set recommendation based on location",
                          trailing: Switch(value: true, onChanged: (value) {}),
                          onTap: () {},
                        ),
                        MPSettingsMenuTile(
                          icon: Iconsax.image,
                          title: "HD Image Quality",
                          subTitle: "Set image quality to be seen",
                          trailing: Switch(value: false, onChanged: (value) {}),
                          onTap: () {},
                        ),
                        Obx(() => MPSettingsMenuTile(
                              icon: Iconsax.moon,
                              title: "Change Theme",
                              subTitle: "Switch theme to light or dark mode",
                              trailing: Switch(
                                value: accountSettingsPageController
                                    .themeSwitch.value,
                                onChanged: (value) {
                                  Get.changeTheme(
                                    accountSettingsPageController
                                            .themeSwitch.value
                                        ? MPAppTheme.darkTheme
                                        : MPAppTheme.lightTheme,
                                  );
                                  accountSettingsPageController
                                      .themeSwitch.value = value;
                                },
                              ),
                              onTap: () {},
                            )),
                        const SizedBox(height: MPSizes.spaceBtwSections),
                        SizedBox(
                          width: double.infinity,
                          child: MPOutlinedButton(
                            text: "Logout",
                            onPressed: () async {
                              await accountSettingsPageController
                                  .logout(context);
                            },
                          ),
                        ),
                        const SizedBox(height: MPSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
  }
}
