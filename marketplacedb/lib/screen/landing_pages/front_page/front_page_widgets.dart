import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/text_fields.dart';
import 'package:marketplacedb/screen/landing_pages/front_page/front_page_controller.dart';
import 'package:marketplacedb/networks/services/google_signin.dart';
import 'package:marketplacedb/screen/password_configuration/pages/forget_password_page.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_images.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/constants/app_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(height: 150, image: AssetImage(MPImages.appLogo)),
        Text(MPTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: MPSizes.sm),
        Text(MPTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FrontPageController controller = FrontPageController.instance;
    return Column(
      children: [
        ValidatorField(
          // validator: (value) => MPValidator.validateEmail(value),
          controller: controller.email,
          labelText: MPTexts.email,
          prefixIcon: const Icon(Iconsax.direct_right),
        ),
        const SizedBox(height: MPSizes.spaceBtwInputFields),
        PasswordValidatorField(
            controller: controller.password,
            labelText: MPTexts.password,
            prefixIcon: const Icon(Iconsax.password_check)),
        const SizedBox(height: MPSizes.spaceBtwInputFields / 2),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(
              onPressed: () {
                Get.to(() => const PasswordConfigurationForgetPasswordPage());
              },
              child: const Text(MPTexts.forgetPassword)),
        ])
      ],
    );
  }
}

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FrontPageController controller = FrontPageController.instance;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: MPColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () async {
                var userData = await GoogleSignAPI.login();
                await controller.loginGoogle(userData?.email);
              },
              icon: const Image(
                  width: MPSizes.iconMd,
                  height: MPSizes.iconMd,
                  image: AssetImage(MPImages.googleIcon)))),
      const SizedBox(width: MPSizes.spaceBtwItems),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: MPColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                  width: MPSizes.iconLg,
                  height: MPSizes.iconLg,
                  image: AssetImage(MPImages.facebookIcon))))
    ]);
  }
}
